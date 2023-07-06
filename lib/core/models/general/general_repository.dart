abstract class GeneralRepository<T> {

  Future<List<T>> getList(String userId,int limit);
  Future<T?> get(String id);
  Future<void> add(T model);
  Future<void> update(T model);
  Future<void> delete(T model);
}