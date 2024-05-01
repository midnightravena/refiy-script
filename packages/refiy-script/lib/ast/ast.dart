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
