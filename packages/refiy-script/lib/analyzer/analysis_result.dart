import '../declaration/namespace/declaration_namespace.dart';
import '../source/source.dart';
import '../source/line_info.dart';
import '../ast/ast.dart';
import 'analyzer.dart';
import 'analysis_error.dart';

class RSSourceAnalysisResult {
  final ASTSource parseResult;

  RSSource get source => parseResult.source!;

  String get fullName => source.fullName;

  LineInfo get lineInfo => source.lineInfo;

  final RSAnalyzer analyzer;

  final List<RSAnalysisError> errors;

  final RSDeclarationNamespace namespace;

  RSSourceAnalysisResult({
    required this.parseResult,
    required this.analyzer,
    required this.errors,
    required this.namespace,
  });
}

class RSModuleAnalysisResult {
  final Map<String, RSSourceAnalysisResult> sourceAnalysisResults;

  final List<RSAnalysisError> errors;

  final ASTCompilation compilation;

  RSModuleAnalysisResult({
    required this.sourceAnalysisResults,
    required this.errors,
    required this.compilation,
  });
}
