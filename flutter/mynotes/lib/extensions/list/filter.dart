extension Filter<T> on Stream {
  Stream<List<T>> filter(bool Function(T) where) =>
    map((items) => items.where(where).toList());
}
