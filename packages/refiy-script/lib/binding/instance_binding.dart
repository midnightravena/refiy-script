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

extension IntBinding on int {
  dynamic htFetch(String id) {
    switch (id) {
      case 'modPow':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            modPow(positionalArgs[0], positionalArgs[1]);
      case 'modInverse':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            modInverse(positionalArgs[0]);
      case 'gcd':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            gcd(positionalArgs[0]);
      case 'isEven':
        return isEven;
      case 'isOdd':
        return isOdd;
      case 'bitLength':
        return bitLength;
      case 'toUnsigned':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toUnsigned(positionalArgs[0]);
      case 'toSigned':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toSigned(positionalArgs[0]);
      case 'toRadixString':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toRadixString(positionalArgs[0]);
      default:
        return (this as num).htFetch(id);
    }
  }
}

extension BigIntBinding on BigInt {
  dynamic htFetch(String id) {
    switch (id) {
      case 'bitLength':
        return bitLength;
      case 'sign':
        return sign;
      case 'isEven':
        return isEven;
      case 'isOdd':
        return isOdd;
      case 'isNegative':
        return isNegative;
      case 'pow':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            pow(positionalArgs.first);
      case 'modPow':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            modPow(positionalArgs[0], positionalArgs[1]);
      case 'modInverse':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            modInverse(positionalArgs.first);
      case 'gcd':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            gcd(positionalArgs.first);
      case 'toUnsigned':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toUnsigned(positionalArgs.first);
      case 'toSigned':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toSigned(positionalArgs.first);
      case 'isValidInt':
        return isValidInt;
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
      case 'toString':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toString();
      case 'toRadixString':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toRadixString(positionalArgs.first);
      default:
        throw RSError.undefined(id);
    }
  }
}

extension DoubleBinding on double {
  dynamic htFetch(String id) {
    switch (id) {
      case 'toDoubleAsFixed':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            double.parse(toStringAsFixed(positionalArgs.first));
      default:
        // ignore: unnecessary_cast
        return (this as num).htFetch(id);
    }
  }
}

extension StringBinding on String {
  dynamic htFetch(String id) {
    switch (id) {
      case 'characters':
        return Characters(this);
      case 'toString':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toString();
      case 'compareTo':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            compareTo(positionalArgs[0]);
      case 'codeUnitAt':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            codeUnitAt(positionalArgs[0]);
      case 'length':
        return length;
      case 'endsWith':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            endsWith(positionalArgs[0]);
      case 'startsWith':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            startsWith(positionalArgs[0], positionalArgs[1]);
      case 'indexOf':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            indexOf(positionalArgs[0], positionalArgs[1]);
      case 'lastIndexOf':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            lastIndexOf(positionalArgs[0], positionalArgs[1]);
      case 'isEmpty':
        return isEmpty;
      case 'isNotEmpty':
        return isNotEmpty;
      case 'substring':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            substring(positionalArgs[0], positionalArgs[1]);
      case 'trim':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            trim();
      case 'trimLeft':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            trimLeft();
      case 'trimRight':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            trimRight();
      case 'padLeft':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            padLeft(positionalArgs[0], positionalArgs[1]);
      case 'padRight':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            padRight(positionalArgs[0], positionalArgs[1]);
      case 'contains':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            contains(positionalArgs[0], positionalArgs[1]);
      case 'replaceFirst':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            replaceFirst(
                positionalArgs[0], positionalArgs[1], positionalArgs[2]);
      case 'replaceAll':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            replaceAll(positionalArgs[0], positionalArgs[1]);
      case 'replaceRange':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            replaceRange(
                positionalArgs[0], positionalArgs[1], positionalArgs[2]);
      case 'split':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            split(positionalArgs[0]);
      case 'toLowerCase':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toLowerCase();
      case 'toUpperCase':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            toUpperCase();
      default:
        throw RSError.undefined(id);
    }
  }
}
