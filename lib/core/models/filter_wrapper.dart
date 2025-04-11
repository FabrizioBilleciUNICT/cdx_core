class DataFilter {
  /// The field or [FieldPath] to filter on.
  final Object field;

  /// Creates a new filter for checking that the given field is equal to the given value.
  final Object? isEqualTo;

  /// Creates a new filter for checking that the given field is not equal to the given value.
  final Object? isNotEqualTo;

  /// Creates a new filter for checking that the given field is less than the given value.
  final Object? isLessThan;

  /// Creates a new filter for checking that the given field is less than or equal to the given value.
  final Object? isLessThanOrEqualTo;

  /// Creates a new filter for checking that the given field is greater than the given value.
  final Object? isGreaterThan;

  /// Creates a new filter for checking that the given field is greater than or equal to the given value.
  final Object? isGreaterThanOrEqualTo;

  /// Creates a new filter for checking that the given array field contains the given value.
  final Object? arrayContains;

  /// Creates a new filter for checking that the given array field contains any of the given values.
  final Iterable<Object?>? arrayContainsAny;

  /// Creates a new filter for checking that the given field equals any of the given values.
  final Iterable<Object?>? whereIn;

  /// Creates a new filter for checking that the given field does not equal any of the given values.
  final Iterable<Object?>? whereNotIn;

  /// Creates a new filter for checking that the given field is null.
  final bool? isNull;

  DataFilter(
    this.field, {
    this.isEqualTo,
    this.isNotEqualTo,
    this.isLessThan,
    this.isLessThanOrEqualTo,
    this.isGreaterThan,
    this.isGreaterThanOrEqualTo,
    this.arrayContains,
    this.arrayContainsAny,
    this.whereIn,
    this.whereNotIn,
    this.isNull,
  });
}

class FilterWrapper {
  final String collection;
  final List<DataFilter> itemsQuery;
  final DataFilter itemGet;
  final String? subCollection;
  FilterWrapper(
      {required this.collection,
      required this.itemsQuery,
      required this.itemGet,
      this.subCollection});
}
