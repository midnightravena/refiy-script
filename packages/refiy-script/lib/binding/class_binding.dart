import 'dart:math' as math;
import 'package:fast_noise/fast_noise.dart';
import '../external/external_class.dart';
import '../value/entity.dart';
import '../type/type.dart';
import '../error/error.dart';
import 'instance_binding.dart';
import '../utils/gaussian_noise.dart';
import '../utils/math.dart';
import '../utils/uid.dart';
import '../utils/crc32b.dart';
import '../value/function/function.dart';

class RSNumberClassBinding extends RSExternalClass {
  RSNumberClassBinding() : super('num');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'num.parse':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            num.tryParse(positionalArgs.first);
      default:
        throw RSError.undefined(id);
    }
  }
}

class RSIntClassBinding extends RSExternalClass {
  RSIntClassBinding() : super('int');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'int.fromEnvironment':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            int.fromEnvironment(positionalArgs[0],
                defaultValue: namedArgs['defaultValue']);
      case 'int.parse':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            int.tryParse(positionalArgs[0], radix: namedArgs['radix']);
      default:
        throw RSError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as int).htFetch(id);
}

class RSBigIntClassBinding extends RSExternalClass {
  RSBigIntClassBinding() : super('BigInt');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'BigInt.zero':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            BigInt.zero;
      case 'BigInt.one':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            BigInt.one;
      case 'BigInt.two':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            BigInt.two;
      case 'BigInt.parse':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            BigInt.tryParse(positionalArgs.first, radix: namedArgs['radix']);
      case 'BigInt.from':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            BigInt.from(positionalArgs.first);
      default:
        throw RSError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as int).htFetch(id);
}

class RSFloatClassBinding extends RSExternalClass {
  RSFloatClassBinding() : super('float');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'float.nan':
        return double.nan;
      case 'float.infinity':
        return double.infinity;
      case 'float.negativeInfinity':
        return double.negativeInfinity;
      case 'float.minPositive':
        return double.minPositive;
      case 'float.maxFinite':
        return double.maxFinite;
      case 'float.parse':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            double.tryParse(positionalArgs[0]);
      default:
        throw RSError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as double).htFetch(id);
}

class RSBooleanClassBinding extends RSExternalClass {
  RSBooleanClassBinding() : super('bool');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'bool.parse':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          return (positionalArgs.first.toLowerCase() == 'true') ? true : false;
        };
      default:
        throw RSError.undefined(id);
    }
  }
}

class RSStringClassBinding extends RSExternalClass {
  RSStringClassBinding() : super('str');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'str.parse':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          return positionalArgs.first.toString();
        };
      default:
        throw RSError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as String).htFetch(id);
}

class RSIteratorClassBinding extends RSExternalClass {
  RSIteratorClassBinding() : super('Iterator');

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as Iterator).htFetch(id);
}

class RSIterableClassBinding extends RSExternalClass {
  RSIterableClassBinding() : super('Iterable');

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as Iterable).htFetch(id);
}

class RSListClassBinding extends RSExternalClass {
  RSListClassBinding() : super('List');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'List':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            List.from(positionalArgs);
      default:
        throw RSError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as List).htFetch(id);
}
