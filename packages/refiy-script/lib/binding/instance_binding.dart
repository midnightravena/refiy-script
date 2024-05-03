import 'dart:math' as math;
import 'dart:collection';
import 'package:characters/characters.dart';
import '../value/entity.dart';
import '../type/type.dart';
import '../locale/locale.dart';
import '../error/error.dart';
import '../utils/jsonify.dart';
import '../value/function/function.dart';
import '../utils/collection.dart';

extension NumBinding on num {
  dynamic htFetch(String id) {
    switch (id) {
      case 'toPercentageString':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          final fractionDigits = positionalArgs.first;
          return (this * 100).toStringAsFixed(fractionDigits).toString() +
              RSLocale.current.percentageMark;
        };
      case 'compareTo':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            compareTo(positionalArgs[0]);
      case 'remainder':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            remainder(positionalArgs[0]);
      case 'isNaN':
        return isNaN;
      case 'isNegative':
        return isNegative;
      case 'isInfinite':
        return isInfinite;
      case 'isFinite':
        return isFinite;
      case 'abs':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            abs();
      case 'sign':
        return sign;
      case 'round':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            round();
      case 'floor':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            floor();
      case 'ceil':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            ceil();
      case 'truncate':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            truncate();
      case 'roundToDouble':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            roundToDouble();
      case 'floorToDouble':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            floorToDouble();
      case 'ceilToDouble':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            ceilToDouble();
      case 'truncateToDouble':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            truncateToDouble();
      case 'toInt':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toInt();
      case 'toDouble':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toDouble();
      case 'toStringAsFixed':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toStringAsFixed(positionalArgs[0]);
      case 'toStringAsExponential':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toStringAsExponential(positionalArgs[0]);
      case 'toStringAsPrecision':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toStringAsPrecision(positionalArgs[0]);
      case 'toString':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toString();
      default:
        throw RSError.undefined(id);
    }
  }
}
