import '../../models/base_object.dart';
import '../../models/filter_wrapper.dart';
import '../../models/result.dart';

typedef ItemCreator<T extends BaseObject> = T Function(Map<String, dynamic>);

abstract class IDatabasePlatform<T extends BaseObject> {
  final FilterWrapper filterWrapper;
  final ItemCreator<T> creator;
  static const int limit = 1000;

  IDatabasePlatform({required this.filterWrapper, required this.creator});

  Future<Result<int, String, List<T>>> getWholeCollection(
      {required int currentCount,
      List<DataFilter>? subCollectionQuery,
      int limit = limit});
  Future<Result<int, String, List<T>>> getItems(
      {List<DataFilter>? subCollectionQuery,
      bool? useCursor,
      bool getCount = false,
      int limit = limit});
  Future<Result<int, String, T?>> getItem({String? id, dynamic docRef});
  Future<Result<int, String, T>> createItem(T item);
  Future<Result<int, String, T>> updateItem(T item);
  Future<Result<int, String, T>> setItem(T item);
  Future<Result<int, String, T?>> deleteItem(String id);
  Future<Result<int, String, T?>> updateFields(String id, Map<String, dynamic> map);
}
