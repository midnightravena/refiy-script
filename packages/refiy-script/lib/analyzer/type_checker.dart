import '../ast/ast.dart';
import '../type/type.dart';
import '../lexicon/lexicon.dart';
import '../lexicon/lexicon_refiy.dart';
import '../type/nominal.dart';

/// A interpreter that compute [RSType] out of [ASTNode]
class RSTypeChecker implements AbstractASTVisitor<RSType> {
  final RSLexicon _lexicon;

  RSTypeChecker({RSLexicon? lexicon}) : _lexicon = lexicon ?? RSLexiconRefiy();

  RSType evalAstNode(ASTNode node) => node.accept(this);

  @override
  RSType visitCompilation(ASTCompilation node) {
    throw 'AstCompilation इत्यत्र एतस्य उपयोगं मा कुरुत ।';
  }

  @override
  RSType visitSource(ASTSource node) {
    throw 'AstSource इत्यत्र एतस्य उपयोगं मा कुरुत ।';
  }

  @override
  RSType visitComment(ASTComment node) {
    throw 'न तु मूल्यम्';
  }

  @override
  RSType visitEmptyLine(ASTEmptyLine node) {
    throw 'न तु मूल्यम्';
  }

  @override
  RSType visitEmptyExpr(ASTEmpty node) {
    throw 'न तु मूल्यम्';
  }

  @override
  RSType visitNullExpr(ASTLiteralNull node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitBooleanExpr(ASTLiteralBoolean node) {
    return HTNominalType(id: 'bool');
  }

  @override
  RSType visitIntLiteralExpr(ASTLiteralInteger node) {
    return HTNominalType(id: 'int');
  }

  @override
  RSType visitFloatLiteralExpr(ASTLiteralFloat node) {
    return HTNominalType(id: 'float');
  }

  @override
  RSType visitStringLiteralExpr(ASTLiteralString node) {
    return HTNominalType(id: 'str');
  }

  @override
  RSType visitStringInterpolationExpr(ASTStringInterpolation node) {
    return HTNominalType(id: 'str');
  }

  @override
  RSType visitIdentifierExpr(IdentifierExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitSpreadExpr(SpreadExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitCommaExpr(CommaExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitListExpr(ListExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitInOfExpr(InOfExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitGroupExpr(GroupExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitIntrinsicTypeExpr(IntrinsicTypeExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitNominalTypeExpr(NominalTypeExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitParamTypeExpr(ParamTypeExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitFunctionTypeExpr(FuncTypeExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitFieldTypeExpr(FieldTypeExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitStructuralTypeExpr(StructuralTypeExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitGenericTypeParamExpr(GenericTypeParameterExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  /// -e, !e，++e, --e
  @override
  RSType visitUnaryPrefixExpr(UnaryPrefixExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitUnaryPostfixExpr(UnaryPostfixExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  /// *, /, ~/, %, +, -, <, >, <=, >=, ==, !=, &&, ||
  @override
  RSType visitBinaryExpr(BinaryExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  /// e1 ? e2 : e3
  @override
  RSType visitTernaryExpr(TernaryExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitAssignExpr(AssignExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitMemberExpr(MemberExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitSubExpr(SubExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitCallExpr(CallExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitAssertStmt(AssertStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitThrowStmt(ThrowStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitExprStmt(ExprStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitBlockStmt(BlockStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitReturnStmt(ReturnStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitIf(IfExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitWhileStmt(WhileStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitDoStmt(DoStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitForStmt(ForExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitForRangeStmt(ForRangeExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitSwitch(SwitchStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitBreakStmt(BreakStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitContinueStmt(ContinueStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitDeleteStmt(DeleteStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitDeleteMemberStmt(DeleteMemberStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitDeleteSubStmt(DeleteSubStmt node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitImportExportDecl(ImportExportDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitNamespaceDecl(NamespaceDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitTypeAliasDecl(TypeAliasDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitVarDecl(VarDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitDestructuringDecl(DestructuringDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitParamDecl(ParamDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitReferConstructCallExpr(RedirectingConstructorCallExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitFuncDecl(FuncDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitClassDecl(ClassDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitEnumDecl(EnumDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitStructDecl(StructDecl node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitStructObjExpr(StructObjExpr node) {
    return RSTypeAny(_lexicon.kAny);
  }

  @override
  RSType visitStructObjField(StructObjField node) {
    return RSTypeAny(_lexicon.kAny);
  }
}
