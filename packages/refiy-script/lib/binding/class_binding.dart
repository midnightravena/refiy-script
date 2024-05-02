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

class RSSetClassBinding extends RSExternalClass {
  RSSetClassBinding() : super('Set');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'Set':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            Set.from(positionalArgs);
      default:
        throw RSError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as Set).htFetch(id);
}

class RSMapClassBinding extends RSExternalClass {
  RSMapClassBinding() : super('Map');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'Map':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            {};
      default:
        throw RSError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as Map).htFetch(id);
}

class RSRandomClassBinding extends RSExternalClass {
  RSRandomClassBinding() : super('Random');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'Random':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            math.Random(positionalArgs.first);
      default:
        throw RSError.undefined(id);
    }
  }

  class RSMathClassBinding extends RSExternalClass {
  RSMathClassBinding() : super('Math');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'Math.e':
        return math.e;
      case 'Math.pi':
        return math.pi;
      case 'Math.degrees':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            degrees(positionalArgs.first.toDouble());
      case 'Math.radians':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            radians(positionalArgs.first.toDouble());
      case 'Math.radiusToSigma':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            radiusToSigma(positionalArgs.first.toDouble());
      case 'Math.gaussianNoise':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          final mean = positionalArgs[0].toDouble();
          final standardDeviation = positionalArgs[1].toDouble();
          final math.Random? randomGenerator = namedArgs['randomGenerator'];
          assert(standardDeviation > 0);
          final num? min = namedArgs['min'];
          final num? max = namedArgs['max'];
          double r;
          do {
            r = gaussianNoise(
              mean,
              standardDeviation,
              randomGenerator: randomGenerator,
            );
          } while ((min != null && r < min) || (max != null && r > max));
          return r;
        };
      case 'Math.noise2d':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          final int size = positionalArgs[0].toInt();
          final seed = namedArgs['seed'] ?? math.Random().nextInt(1 << 32);
          final frequency = namedArgs['frequency'];
          final noiseTypeString = namedArgs['noiseType'];
          NoiseType noiseType;
          switch (noiseTypeString) {
            case 'perlinFractal':
              noiseType = NoiseType.perlinFractal;
            case 'perlin':
              noiseType = NoiseType.perlin;
            case 'cubicFractal':
              noiseType = NoiseType.cubicFractal;
            case 'cubic':
            default:
              noiseType = NoiseType.cubic;
          }
          return noise2(
            size,
            size,
            seed: seed,
            frequency: frequency,
            noiseType: noiseType,
          );
        };
      case 'Math.min':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          if (positionalArgs[0] == null) {
            return positionalArgs[1];
          }
          if (positionalArgs[1] == null) {
            return positionalArgs[0];
          }
          return math.min(positionalArgs[0] as num, positionalArgs[1] as num);
        };
      case 'Math.max':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          if (positionalArgs[0] == null) {
            return positionalArgs[1];
          }
          if (positionalArgs[1] == null) {
            return positionalArgs[0];
          }
          return math.max(positionalArgs[0] as num, positionalArgs[1] as num);
        };
      case 'Math.sqrt':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            math.sqrt(positionalArgs.first as num);
      case 'Math.pow':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            math.pow(positionalArgs[0] as num, positionalArgs[1] as num);
      case 'Math.sin':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            math.sin(positionalArgs.first as num);
      case 'Math.cos':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            math.cos(positionalArgs.first as num);
      case 'Math.tan':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            math.tan(positionalArgs.first as num);
      case 'Math.exp':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            math.exp(positionalArgs.first as num);
      case 'Math.log':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            math.log(positionalArgs.first as num);
      case 'Math.parseInt':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            int.tryParse(positionalArgs.first as String,
                radix: namedArgs['radix']) ??
            0;
      case 'Math.parseDouble':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            double.tryParse(positionalArgs.first as String) ?? 0.0;
      case 'Math.sum':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            (positionalArgs.first as List<num>)
                .reduce((value, element) => value + element);
      case 'Math.checkBit':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            ((positionalArgs[0] as int) & (1 << (positionalArgs[1] as int))) !=
            0;
      case 'Math.bitLS':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            (positionalArgs[0] as int) << (positionalArgs[1] as int);
      case 'Math.bitRS':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            (positionalArgs[0] as int) >> (positionalArgs[1] as int);
      case 'Math.bitAnd':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            (positionalArgs[0] as int) & (positionalArgs[1] as int);
      case 'Math.bitOr':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            (positionalArgs[0] as int) | (positionalArgs[1] as int);
      case 'Math.bitNot':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            ~(positionalArgs[0] as int);
      case 'Math.bitXor':
        return (RSEntity entity,
                {List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {},
                List<RSType> typeArgs = const []}) =>
            (positionalArgs[0] as int) ^ (positionalArgs[1] as int);

      default:
        throw RSError.undefined(id);
    }
  }
}


  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as math.Random).htFetch(id);
}

class RSHashClassBinding extends RSExternalClass {
  RSHashClassBinding() : super('Hash');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'Hash.uid4':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          return uid4(positionalArgs.first);
        };
      case 'Hash.crcString':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          String data = positionalArgs[0];
          int crc = positionalArgs[1] ?? 0;
          return crcString(data, crc);
        };
      case 'Hash.crcInt':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          String data = positionalArgs[0];
          int crc = positionalArgs[1] ?? 0;
          return crcInt(data, crc);
        };
      default:
        throw RSError.undefined(id);
    }
  }
}

class RSSystemClassBinding extends RSExternalClass {
  RSSystemClassBinding() : super('OS');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'OS.now':
        return DateTime.now().millisecondsSinceEpoch;
      default:
        throw RSError.undefined(id);
    }
  }
}

class RSFutureClassBinding extends RSExternalClass {
  RSFutureClassBinding() : super('Future');

  @override
  dynamic memberGet(String id, {String? from}) {
    switch (id) {
      case 'Future':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          final HTFunction func = positionalArgs.first;
          return Future(() => func.call());
        };
      case 'Future.wait':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          final futures = List<Future<dynamic>>.from(positionalArgs.first);
          return Future.wait(futures);
        };
      case 'Future.value':
        return (RSEntity entity,
            {List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {},
            List<RSType> typeArgs = const []}) {
          return Future.value(positionalArgs.first);
        };
      default:
        throw RSError.undefined(id);
    }
  }

  @override
  dynamic instanceMemberGet(dynamic object, String id) =>
      (object as Future).htFetch(id);
}
