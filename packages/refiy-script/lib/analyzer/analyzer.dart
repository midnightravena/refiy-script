import 'package:path/path.dart' as path;
import '../source/source.dart';
import '../resource/resource.dart';
import '../resource/resource_context.dart';
import '../resource/overlay/overlay_context.dart';
import '../declaration/namespace/declaration_namespace.dart';
import '../error/error.dart';
import '../error/error_handler.dart';
import '../ast/ast.dart';
import 'analysis_result.dart';
import 'analysis_error.dart';
import '../ast/visitor/recursive_ast_visitor.dart';
import '../constant/constant_interpreter.dart';
import 'analyzer_impl.dart';
import '../lexicon/lexicon.dart';
import '../lexicon/lexicon_refiy.dart';
import '../common/internal_identifier.dart';

/// Namespace that holds symbols for analyzing, the value is either the declaration AST or null.
typedef AnalysisNamespace = RSDeclarationNamespace<ASTNode?>;

class AnalyzerConfig {
  bool computeConstantExpression;

  bool doStaticAnalysis;

  bool allowVariableShadowing;

  bool allowImplicitVariableDeclaration;

  bool allowImplicitNullToZeroConversion;

  bool allowImplicitEmptyValueToFalseConversion;

  bool printPerformanceStatistics;

  AnalyzerConfig({
    this.computeConstantExpression = false,
    this.doStaticAnalysis = false,
    this.allowVariableShadowing = true,
    this.allowImplicitVariableDeclaration = false,
    this.allowImplicitNullToZeroConversion = false,
    this.allowImplicitEmptyValueToFalseConversion = false,
    this.printPerformanceStatistics = false,
  });
}

class RSAnalyzer extends RecursiveASTVisitor<void> {
  final errorProcessors = <ErrorProcessor>[];

  AnalyzerConfig config;

  ErrorHandlerConfig? get errorConfig => null;

  late final RSLexicon _lexicon;

  late final AnalysisNamespace globalNamespace;

  late AnalysisNamespace _currentNamespace;

  final Map<String, AnalysisNamespace> namespaces = {};

  late RSSource _currentSource;

  RSResourceContext<RSSource> sourceContext;

  List<RSAnalysisError> _currentErrors = [];
  Map<String, RSSourceAnalysisResult> _currentAnalysisResults = {};

  RSAnalyzer({
    AnalyzerConfig? config,
    RSResourceContext<RSSource>? sourceContext,
    RSLexicon? lexicon,
  })  : config = config ?? AnalyzerConfig(),
        sourceContext = sourceContext ?? HTOverlayContext(),
        _lexicon = lexicon ?? RSLexiconRefiy() {
    globalNamespace = RSDeclarationNamespace(
        lexicon: _lexicon, id: InternalIdentifier.global);
    _currentNamespace = globalNamespace;
  }

  RSModuleAnalysisResult analyzeCompilation(
    ASTCompilation compilation, {
    String? module,
    bool globallyImport = false,
  }) {
    final tik = DateTime.now().millisecondsSinceEpoch;
    _currentErrors = [];
    _currentAnalysisResults = {};

    // Resolve namespaces
    for (final source in compilation.sources.values) {
      resolve(source);
    }

    for (final source in compilation.sources.values) {
      // the second scan, handle import.
      handleImport(source);
    }

    for (final source in compilation.sources.values) {
      // the third & forth scan.
      _analyze(source);
    }

    if (globallyImport) {
      globalNamespace.import(_currentAnalysisResults.values.last.namespace);
    }
    final result = RSModuleAnalysisResult(
      sourceAnalysisResults: _currentAnalysisResults,
      errors: _currentErrors,
      compilation: compilation,
    );
    if (config.printPerformanceStatistics) {
      final tok = DateTime.now().millisecondsSinceEpoch;
      print('विश्लेषित [${compilation.entryFullname}]\t${tok - tik}ms');
    }
    return result;
  }

  void resolve(ASTSource source) {
    source.isResolved = true;
    if (source.resourceType == HTResourceType.refiyLiteralCode) {
      _currentNamespace = globalNamespace;
    } else {
      if (namespaces[source.fullName] != null) {
        _currentNamespace = namespaces[source.fullName]!;
      } else {
        namespaces[source.fullName] = _currentNamespace =
            RSDeclarationNamespace(
                lexicon: _lexicon,
                id: source.fullName,
                closure: globalNamespace);
      }
    }
    for (final node in source.nodes) {
      resolveAST(node);
    }
  }

  void handleImport(ASTSource source) {}

  RSSourceAnalysisResult _analyze(ASTSource source) {
    final sourceErrors = <RSAnalysisError>[];

    // the third scan, compute constant values
    if (config.computeConstantExpression) {
      final constantInterpreter = HTConstantInterpreter();
      source.accept(constantInterpreter);
      sourceErrors.addAll(constantInterpreter.errors);
    }

    // the forth scan, do static analysis
    if (config.doStaticAnalysis) {
      final analyzer = RSAnalyzerImpl(lexicon: _lexicon);
      source.accept(analyzer);
      sourceErrors.addAll(analyzer.errors);
    }

    final sourceAnalysisResult = RSSourceAnalysisResult(
        parseResult: source,
        analyzer: this,
        errors: sourceErrors,
        namespace: _currentNamespace);

    _currentAnalysisResults[sourceAnalysisResult.fullName] =
        sourceAnalysisResult;
    _currentErrors.addAll(sourceAnalysisResult.errors);

    return sourceAnalysisResult;
  }

  void resolveAST(ASTNode node) => node.accept(this);

  @override
  void visitCompilation(ASTCompilation node) {
    throw '`visitCompilation()` इत्यस्य स्थाने `analyzeCompilation()` इत्यस्य उपयोगं कुर्वन्तु ।';
  }

  @override
  void visitSource(ASTSource node) {
    throw '`visitSource` इत्यस्य स्थाने `resolve() & analyzer()` इत्यस्य उपयोगं कुर्वन्तु ।';
  }

  @override
  void visitIdentifierExpr(IdentifierExpr node) {
    node.analysisNamespace = _currentNamespace;
  }

  @override
  void visitDeleteStmt(DeleteStmt node) {
    _currentNamespace.delete(node.symbol);
  }

  @override
  void visitDeleteMemberStmt(DeleteMemberStmt node) {
    node.subAccept(this);
  }

  @override
  void visitDeleteSubStmt(DeleteSubStmt node) {
    node.subAccept(this);
  }

  @override
  void visitImportExportDecl(ImportExportDecl node) {
    if (!_currentSource.fullName
        .startsWith(InternalIdentifier.anonymousScript)) {
      final currentDir = path.dirname(_currentSource.fullName);
      final fromPath = sourceContext.getAbsolutePath(
          key: node.fromPath!, dirName: currentDir);
      if (_currentSource.fullName == fromPath) {
        final err = RSAnalysisError.importSelf(
            filename: node.source!.fullName,
            line: node.line,
            column: node.column,
            offset: node.offset,
            length: node.length);
        _currentErrors.add(err);
      }
    }
    
    if (!node.isExport) {
    } else {}
  }

  @override
  void visitNamespaceDecl(NamespaceDecl node) {
    node.subAccept(this);
  }

  @override
  void visitTypeAliasDecl(TypeAliasDecl node) {
    node.subAccept(this);
    _currentNamespace.define(node.id.id, node);
  }

  @override
  void visitVarDecl(VarDecl node) {
    node.subAccept(this);
    _currentNamespace.define(node.id.id, node,
        override: config.allowVariableShadowing);
  }

  @override
  void visitDestructuringDecl(DestructuringDecl node) {
    node.subAccept(this);
    for (final key in node.ids.keys) {
      _currentNamespace.define(key.id, null,
          override: config.allowVariableShadowing);
    }
  }

  @override
  void visitParamDecl(ParamDecl node) {
    node.subAccept(this);
    _currentNamespace.define(node.id.id, node);
  }

  @override
  void visitReferConstructCallExpr(RedirectingConstructorCallExpr node) {
    node.subAccept(this);
  }

  @override
  void visitFuncDecl(FuncDecl node) {
    for (final param in node.genericTypeParameters) {
      visitGenericTypeParamExpr(param);
    }
    node.returnType?.accept(this);
    node.redirectingConstructorCall?.accept(this);
    final savedCurrrentNamespace = _currentNamespace;
    _currentNamespace = RSDeclarationNamespace(
        lexicon: _lexicon, id: node.internalName, closure: _currentNamespace);
    for (final param in node.paramDecls) {
      visitParamDecl(param);
    }
    node.definition?.accept(this);
    _currentNamespace = savedCurrrentNamespace;
  }

  @override
  void visitClassDecl(ClassDecl node) {
    for (final param in node.genericTypeParameters) {
      visitGenericTypeParamExpr(param);
    }
    node.superType?.accept(this);
    for (final implementsType in node.implementsTypes) {
      visitNominalTypeExpr(implementsType);
    }
    for (final withType in node.withTypes) {
      visitNominalTypeExpr(withType);
    }
  }

  @override
  void visitEnumDecl(EnumDecl node) {
  }

  @override
  void visitStructDecl(StructDecl node) {
  }

  @override
  void visitStructObjField(StructObjField node) {}

  @override
  void visitStructObjExpr(StructObjExpr node) {}
}
