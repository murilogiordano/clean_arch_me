import 'package:clean_arch_me/src/_exports.dart';
import 'package:flutter_test/flutter_test.dart';

class Entidade {
  final String test;

  Entidade(this.test);
}

class Dto {
  final String test;

  Dto(this.test);

  Entidade toEntity() {
    return Entidade("${test}2");
  }
}

class Testee extends UsecaseMe<Entidade, Dto> {}

void main() {
  const _test = 'teste';
  test(
      'When repository returns Success, failure should be null and data should not',
      () async {
    onTry(Dto? dto) async {
      return Dto(_test);
    }

    final usecase = Testee();
    final (error, data) = await usecase(
      onTry: onTry,
      toEntity: (dto) {
        return dto.toEntity();
      },
    );
    expect(error, isNull);
    expect(data, isNotNull);
  });

  test(
      'When repository Throws exception, failure should not be null and data should',
      () async {
    onTry(Dto? dto) async {
      throw Failure();
    }

    final usecase = Testee();
    final (error, data) = await usecase(
      onTry: onTry,
      toEntity: (dto) {
        return dto.toEntity();
      },
    );
    expect(error, isNotNull);
    expect(data, isNull);
  });

  test(
      'When repository returns Success and accepts payload, failure should be null and data should not',
      () async {
    onTry(Dto? dto) async {
      return Dto(_test);
    }

    toDto(Entidade? entidade) {
      return Dto(entidade!.test);
    }

    final usecase = Testee();
    final (error, data) = await usecase(
      onTry: onTry,
      toEntity: (dto) {
        return dto.toEntity();
      },
      toDto: toDto,
      payload: Entidade(_test),
    );
    expect(error, isNull);
    expect(data, isNotNull);
    expect(data?.test, equals(_test + "2"));
  });

  test(
      'When repository Throws exception and accepts payload, failure should not be null and data should',
      () async {
    onTry(Dto? dto) async {
      throw Failure();
    }

    toDto(Entidade? entidade) {
      return Dto(entidade!.test);
    }

    final usecase = Testee();
    final (error, data) = await usecase(
      onTry: onTry,
      toEntity: (dto) {
        return dto.toEntity();
      },
      toDto: toDto,
      payload: Entidade(_test),
    );
    expect(error, isNotNull);
    expect(data, isNull);
  });
}
