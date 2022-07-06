extension GetOrNullMap on Map {
  /// Get a map inside a map
  Map<String, dynamic>? get(String key) {
    var v = this[key];
    if (v == null) {
      return null;
    }
    return v;
  }

  /// Get a value inside a map.
  /// If it is null this returns null, if of another type this throws.
  T? getT<T>(String key) {
    var v = this[key];
    if (v == null) {
      return null;
    }
    if (v is! T) {
      throw Exception('Invalid type: ${v.runtimeType} should be $T');
    }
    return v;
  }

  /// Get a List<Map<String, dynamic>>> from a map.
  List<Map<String, dynamic>>? getList(String key) {
    var v = this[key];
    if (v == null) {
      return null;
    }
    if (v is! List<dynamic>) {
      throw Exception('Invalid type: ${v.runtimeType} should be of type List');
    }

    return (v.toList()).cast<Map<String, dynamic>>();
  }

}

/// List Utility.
extension ListUtil<E> on Iterable<E> {
  /// Same as [elementAt] but if the index is higher than the length returns
  /// null
  E? elementAtSafe(int index) {
    if (index >= length) {
      return null;
    }
    return elementAt(index);
  }
}