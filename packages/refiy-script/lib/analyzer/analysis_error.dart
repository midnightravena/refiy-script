import '../error/error.dart';
import '../error/error_severity.dart';
import 'diagnostic.dart';
import '../locale/locale.dart';

class RSAnalysisError implements RSError {
  @override
  final ErrorCode code;

  @override
  String get name => code.toString().split('.').last;

  @override
  final ErrorType type;

  @override
  ErrorSeverity get severity => type.severity;

  String? _message;

  @override
  String? get message => _message;

  @override
  final String? extra;

  @override
  final String? correction;

  @override
  final String filename;

  @override
  final int line;

  @override
  final int column;

  @override
  final int offset;

  @override
  final int length;

  final List<RSDiagnosticMessage> contextMessages;

  RSAnalysisError(this.code, this.type,
      {String? message,
      this.extra,
      List<String> interpolations = const [],
      this.correction,
      required this.filename,
      required this.line,
      required this.column,
      this.offset = 0,
      this.length = 0,
      this.contextMessages = const []}) {
    if (message != null) {
      for (var i = 0; i < interpolations.length; ++i) {
        message = message!.replaceAll('{$i}', interpolations[i].toString());
      }
      _message = message;
    }
  }

  @override
  String toString() {
    final output = StringBuffer();
    output.writeln("$message (at [$filename:$line:$column])");
    return output.toString();
  }

  RSAnalysisError.fromError(RSError error,
      {required String filename,
      required int line,
      required int column,
      int offset = 0,
      int length = 0,
      List<RSDiagnosticMessage> contextMessages = const []})
      : this(error.code, error.type,
            message: error.message,
            extra: error.extra,
            correction: error.correction,
            filename: filename,
            line: line,
            column: column,
            contextMessages: contextMessages);

  RSAnalysisError.constValue(String id,
      {String? extra,
      String? correction,
      required String filename,
      required int line,
      required int column,
      required int offset,
      required int length})
      : this(ErrorCode.constValue, ErrorType.staticWarning,
            message: RSLocale.current.errorConstValue,
            extra: extra,
            interpolations: [id],
            correction: correction,
            filename: filename,
            line: line,
            column: column,
            offset: offset,
            length: length);

  RSAnalysisError.importSelf({
    String? extra,
    String? correction,
    required String filename,
    required int line,
    required int column,
    required int offset,
    required int length,
  }) : this(ErrorCode.importSelf, ErrorType.staticWarning,
            message: RSLocale.current.errorImportSelf,
            extra: extra,
            correction: correction,
            filename: filename,
            line: line,
            column: column,
            offset: offset,
            length: length);

  /// Error: Type check failed.
  RSAnalysisError.assignType(
    String id,
    String valueType,
    String declValue, {
    String? extra,
    String? correction,
    required String filename,
    required int line,
    required int column,
    required int offset,
    required int length,
  }) : this(ErrorCode.assignType, ErrorType.staticTypeWarning,
            message: RSLocale.current.errorAssignType,
            interpolations: [id, valueType, declValue],
            extra: extra,
            correction: correction,
            filename: filename,
            line: line,
            column: column,
            offset: offset,
            length: length);
}
