import '../_exports.dart';

abstract class IUsecaseMe<T> {
  Future<(Failure?, T?)> execute();
}

class UsecaseMe<TEntity, TDto> implements IUsecaseMe<TEntity> {
  late Future<TDto> Function(TDto? dto) _onTry;
  late TEntity Function(TDto dto) _toEntity;
  late TDto Function(TEntity dto)? _toDto;
  late TEntity? _payload;

  Future<(Failure?, TEntity?)> call({
    required Future<TDto> Function(TDto? dto) onTry,
    required TEntity Function(TDto dto) toEntity,
    TDto Function(TEntity dto)? toDto,
    TEntity? payload,
  }) async {
    _onTry = onTry;
    _toEntity = toEntity;
    _toDto = toDto;
    _payload = payload;
    if (toDto != null && payload == null) {
      throw Exception();
    }
    if (toDto == null && payload != null) {
      throw Exception();
    }
    return await execute();
  }

  @override
  Future<(Failure?, TEntity?)> execute() async {
    try {
      final _dto = _toDto == null ? null : _toDto!(_payload!);
      final result = await _onTry(_dto);
      final converted = _toEntity(result);
      return (null, converted);
    } on Failure catch (f) {
      return (f, null);
    } on Exception catch (_) {
      return (Failure(), null);
    }
  }
}
