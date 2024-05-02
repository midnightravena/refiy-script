import 'dart:convert';
import 'package:refiy_script/refiy_script.dart';
import '../external/external_class.dart';
import '../utils/jsonify.dart';
import '../value/struct/struct.dart';

class RSRefiyClassBinding extends RSExternalClass {
  RSRefiyClassBinding() : super('Refiy');

  @override
  dynamic instanceMemberGet(dynamic object, String id) {
    final refiy = object as Refiy;
    switch (id) {
      case 'stringify':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            refiy.lexicon.stringify(positionalArgs.first);
      case 'createStructfromJson':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          final jsonData = positionalArgs.first as Map<dynamic, dynamic>;
          return refiy.interpreter.createStructfromJson(jsonData);
        };
      case 'jsonify':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          final object = positionalArgs.first;
          if (object is HTStruct) {
            return jsonifyStruct(object);
          } else if (object is Iterable) {
            return jsonifyList(object);
          } else if (isJsonDataType(object)) {
            return refiy.lexicon.stringify(object);
          } else {
            return jsonEncode(object);
          }
        };
      case 'eval':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          final code = positionalArgs.first as String;
          final HTContext savedContext = refiy.interpreter.getContext();
          final result = refiy.eval(code);
          refiy.interpreter.setContext(context: savedContext);
          return result;
        };
      case 'require':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            refiy.require(positionalArgs.first);
      case 'help':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            refiy.help(positionalArgs.first);
      default:
        throw RSError.undefined(id);
    }
  }
}
