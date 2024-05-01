import 'package:pub_semver/pub_semver.dart';
import '../declaration/namespace/declaration_namespace.dart';
import '../parser/token.dart';
import '../source/source.dart';
import '../declaration/declaration.dart';
import '../../resource/resource.dart' show HTResourceType;
import '../../source/line_info.dart';
import '../error/error.dart';
import '../../common/internal_identifier.dart';
import '../common/function_category.dart';

part 'visitor/abstract_ast_visitor.dart';

abstract class ASTNode {
  final String type;

  List<ASTAnnotation> precedings = [];

  ASTAnnotation? trailing;

  ASTAnnotation? trailingAfterComma;

  List<ASTAnnotation> succeedings = [];

  String get documentation {
    final documentation = StringBuffer();
    for (final line in precedings) {
      if (line.isDocumentation) {
        documentation.writeln(line.content);
      }
    }
    return documentation.toString();
  }

  final bool isStatement;

  bool get isExpression => !isStatement;

  final bool isBlock;

  bool get isConstValue => value != null;

  final bool isAwait;
  dynamic value;

  final RSSource? source;

  final int line;

  final int column;

  final int offset;

  final int length;

  int get end => offset + length;

  /// Visit this node
  dynamic accept(AbstractASTVisitor visitor);

  /// Visit all the sub nodes of this, doing nothing by default.
  void subAccept(AbstractASTVisitor visitor) {}

  ASTNode(
    this.type, {
    this.isStatement = false,
    this.isAwait = false,
    this.isBlock = false,
    this.source,
    this.line = 0,
    this.column = 0,
    this.offset = 0,
    this.length = 0,
  });
}

abstract class ASTAnnotation extends ASTNode {
  final String content;

  final bool isDocumentation;

  ASTAnnotation(
    super.type, {
    required this.content,
    required this.isDocumentation,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  });
}

class ASTComment extends ASTAnnotation {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitComment(this);

  final bool isMultiLine;

  final bool isTrailing;

  ASTComment({
    required String content,
    required super.isDocumentation,
    required this.isMultiLine,
    required this.isTrailing,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.comment, content: content);

  ASTComment.fromCommentToken(TokenComment token)
      : this(
          content: token.literal,
          isDocumentation: token.isDocumentation,
          isMultiLine: token.isMultiLine,
          isTrailing: token.isTrailing,
        );
}

class ASTEmptyLine extends ASTAnnotation {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitEmptyLine(this);

  ASTEmptyLine({
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(
          InternalIdentifier.emptyLine,
          content: '\n',
          isDocumentation: false,
        );
}

/// Parse result of a single file
class ASTSource extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitSource(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    for (final stmt in nodes) {
      stmt.accept(visitor);
    }
  }

  String get fullName => source!.fullName;

  HTResourceType get resourceType => source!.type;

  LineInfo get lineInfo => source!.lineInfo;

  final List<ImportExportDecl> imports;

  final List<ASTNode> nodes;

  final List<RSError> errors;

  bool isResolved = false;

  ASTSource({
    required this.nodes,
    this.imports = const [],
    this.errors = const [],
    required super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.source, isStatement: true) {
  }
}

class ASTCompilation extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitCompilation(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    for (final node in values.values) {
      node.accept(visitor);
    }
    for (final node in sources.values) {
      node.accept(visitor);
    }
  }

  final Map<String, ASTSource> values;

  final Map<String, ASTSource> sources;

  final String entryFullname;

  final HTResourceType entryResourceType;

  final List<RSError> errors;

  final Version? version;

  ASTCompilation({
    required this.values,
    required this.sources,
    required this.entryFullname,
    required this.entryResourceType,
    required this.errors,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
    this.version,
  }) : super(InternalIdentifier.compilation, isStatement: true) {
  }
}

class ASTEmpty extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitEmptyExpr(this);

  ASTEmpty({
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.empty);
}

class ASTLiteralNull extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitNullExpr(this);

  ASTLiteralNull({
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.literalNull);
}

class ASTLiteralBoolean extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitBooleanExpr(this);

  final bool _value;

  @override
  bool get value => _value;

  ASTLiteralBoolean(
    this._value, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.literalBoolean);
}

class ASTLiteralInteger extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitIntLiteralExpr(this);

  final int _value;

  @override
  int get value => _value;

  ASTLiteralInteger(
    this._value, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.literalInteger);
}

class ASTLiteralFloat extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitFloatLiteralExpr(this);

  final double _value;

  @override
  double get value => _value;

  ASTLiteralFloat(
    this._value, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.literalFloat);
}

class ASTLiteralString extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitStringLiteralExpr(this);

  final String _value;

  @override
  String get value => _value;

  final String quotationLeft;

  final String quotationRight;

  ASTLiteralString(
    this._value,
    this.quotationLeft,
    this.quotationRight, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.literalString);
}

class ASTStringInterpolation extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitStringInterpolationExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    for (final expr in interpolations) {
      expr.accept(visitor);
    }
  }

  final String text;

  final String quotationLeft;

  final String quotationRight;

  final List<ASTNode> interpolations;

  ASTStringInterpolation(
    this.text,
    this.quotationLeft,
    this.quotationRight,
    this.interpolations, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(
          InternalIdentifier.stringInterpolation,
          isAwait: interpolations.any((element) => element.isAwait),
        ) {
    // for (final ast in interpolations) {
    //   ast.parent = this;
    // }
  }
}

class IdentifierExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitIdentifierExpr(this);

  final String id;

  final bool isMarked;

  final bool isLocal;

  /// This value is null untill assigned by analyzer
  RSDeclarationNamespace<ASTNode?>? analysisNamespace;

  /// This value is null untill assigned by analyzer
  HTDeclaration? declaration;

  IdentifierExpr(
    this.id, {
    this.isMarked = false,
    this.isLocal = true,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.identifierExpression);

  IdentifierExpr.fromToken(
    Token idTok, {
    bool isMarked = false,
    bool isLocal = true,
    RSSource? source,
  }) : this(idTok.literal,
            isLocal: isLocal,
            source: source,
            line: idTok.line,
            column: idTok.column,
            offset: idTok.offset,
            length: idTok.length);
}

class SpreadExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitSpreadExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    collection.accept(visitor);
  }

  final ASTNode collection;

  SpreadExpr(
    this.collection, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(
          InternalIdentifier.spreadExpression,
          isAwait: collection.isAwait,
        );
}

class CommaExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitCommaExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    for (final item in list) {
      item.accept(visitor);
    }
  }

  final List<ASTNode> list;

  final bool isLocal;

  CommaExpr(
    this.list, {
    this.isLocal = true,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(
          InternalIdentifier.commaExpression,
          isAwait: list.any((element) => element.isAwait),
        );
}

class ListExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitListExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    for (final item in list) {
      item.accept(visitor);
    }
  }

  final List<ASTNode> list;

  ListExpr(
    this.list, {
    RSSource? source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(
          InternalIdentifier.literalList,
          isAwait: list.any((element) => element.isAwait),
        );
}

class InOfExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitInOfExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    collection.accept(visitor);
  }

  final ASTNode collection;

  final bool valueOf;

  InOfExpr(
    this.collection,
    this.valueOf, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(
          InternalIdentifier.inOfExpression,
          isAwait: collection.isAwait,
        );
}

class GroupExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitGroupExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    inner.accept(visitor);
  }

  final ASTNode inner;

  GroupExpr(
    this.inner, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(
          InternalIdentifier.groupExpression,
          isAwait: inner.isAwait,
        );
}

abstract class TypeExpr extends ASTNode {
  bool get isLocal;

  TypeExpr(
    super.exprType, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  });
}

class IntrinsicTypeExpr extends TypeExpr {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitIntrinsicTypeExpr(this);

  final IdentifierExpr id;

  final bool isTop;

  final bool isBottom;

  @override
  final bool isLocal;

  IntrinsicTypeExpr({
    required this.id,
    this.isTop = false,
    this.isBottom = false,
    this.isLocal = true,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.intrinsicTypeExpression);
}

class NominalTypeExpr extends TypeExpr {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitNominalTypeExpr(this);

  final IdentifierExpr id;

  final List<IdentifierExpr> namespacesWithin;

  final List<TypeExpr> arguments;

  final bool isNullable;

  @override
  final bool isLocal;

  NominalTypeExpr({
    required this.id,
    this.namespacesWithin = const [],
    this.arguments = const [],
    this.isNullable = false,
    this.isLocal = true,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.nominalTypeExpression);
}

class ParamTypeExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitParamTypeExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    declType.accept(visitor);
  }

  /// Wether this is an optional positional parameter.
  final bool isOptionalPositional;

  /// Wether this is a variadic parameter.
  final bool isVariadic;

  /// Wether this is a optional named parameter.
  bool get isNamed => id != null;

  final IdentifierExpr? id;

  final TypeExpr declType;

  ParamTypeExpr(
    this.declType, {
    this.id,
    this.isOptionalPositional = false,
    this.isVariadic = false,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.paramTypeExpression);
}

class FuncTypeExpr extends TypeExpr {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitFunctionTypeExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    for (final item in paramTypes) {
      item.accept(visitor);
    }
    returnType.accept(visitor);
  }

  final List<GenericTypeParameterExpr> genericTypeParameters;

  final List<ParamTypeExpr> paramTypes;

  final TypeExpr returnType;

  final bool hasOptionalParam;

  final bool hasNamedParam;

  @override
  final bool isLocal;

  FuncTypeExpr(
    this.returnType, {
    this.genericTypeParameters = const [],
    this.paramTypes = const [],
    this.hasOptionalParam = false,
    this.hasNamedParam = false,
    this.isLocal = true,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.functionTypeExpression);
}

class FieldTypeExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitFieldTypeExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    fieldType.accept(visitor);
  }

  final String id;

  final TypeExpr fieldType;

  FieldTypeExpr(
    this.id,
    this.fieldType, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.fieldTypeExpression);
}

class StructuralTypeExpr extends TypeExpr {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitStructuralTypeExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    for (final field in fieldTypes) {
      field.accept(visitor);
    }
  }

  final List<FieldTypeExpr> fieldTypes;

  @override
  final bool isLocal;

  StructuralTypeExpr({
    this.fieldTypes = const [],
    this.isLocal = true,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.structuralTypeExpression);
}

class GenericTypeParameterExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitGenericTypeParamExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    superType?.accept(visitor);
  }

  final IdentifierExpr id;

  final NominalTypeExpr? superType;

  GenericTypeParameterExpr(
    this.id, {
    this.superType,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.genericTypeParamExpression);
}

/// -e, !e，++e, --e
class UnaryPrefixExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitUnaryPrefixExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    object.accept(visitor);
  }

  final String op;

  final ASTNode object;

  UnaryPrefixExpr(
    this.op,
    this.object, {
    super.isAwait,
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.unaryPrefixExpression);
}

/// e++, e--
class UnaryPostfixExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) =>
      visitor.visitUnaryPostfixExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    object.accept(visitor);
  }

  final ASTNode object;

  final String op;

  UnaryPostfixExpr(
    this.object,
    this.op, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(InternalIdentifier.unaryPostfixExpression);
}

class BinaryExpr extends ASTNode {
  @override
  dynamic accept(AbstractASTVisitor visitor) => visitor.visitBinaryExpr(this);

  @override
  void subAccept(AbstractASTVisitor visitor) {
    left.accept(visitor);
    right.accept(visitor);
  }

  final ASTNode left;

  final String op;

  final ASTNode right;

  BinaryExpr(
    this.left,
    this.op,
    this.right, {
    super.source,
    super.line = 0,
    super.column = 0,
    super.offset = 0,
    super.length = 0,
  }) : super(
          InternalIdentifier.binaryExpression,
          isAwait: left.isAwait || right.isAwait,
        );
}
