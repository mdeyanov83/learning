extension Filter<T> on Stream<List<T>> {
  Stream<List<T>> filter(bool Function(T) whereClause) =>
    map((items) => items.where(whereClause).toList());
}
