abstract class IRepoMeFindBy<T> {
  Future<T> findBy({required String query});
}

abstract class IRepoMeFindAll<T> {
  Future<T> findAll(
      {String? filter, required int maxCount, required int skipCount});
}

abstract class IRepoCreate<T> {
  Future<T> create({required T data});
}

abstract class IRepoUpdate<T> {
  Future<T> update({required T data});
}

abstract class IRepoDelete<T> {
  Future<T> delete({required String query});
}
