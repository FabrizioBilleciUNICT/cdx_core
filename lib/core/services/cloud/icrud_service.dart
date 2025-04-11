import 'package:rxdart/rxdart.dart';
import '../../models/base_object.dart';
import '../../models/filter_wrapper.dart';
import '../../models/result.dart';
import '../cloud_platform/idatabase_platform.dart';

abstract class ICrudService<T extends BaseObject> {
  ValueStream<T?> itemStream();
  ValueStream<Result<int, String, T?>> resultStream();
  ValueStream<List<T>> itemsStream();

  Future<Result<int, String, T?>> getItem({String? id});
  Future<Result<int, String, T?>> itemWhere({
    required List<DataFilter> query,
    required T? Function(List<T>) choiceFunction
  });
  Future<Result<int, String, List<T>>> getItems(
      {Future<Result<int, String, List<T>>> Function()? alternativeFunc});
  Future<Result<int, String, T?>> createItem(T item,
      {Future<Result<int, String, T?>> Function(T)? alternativeFunc});
  Future<Result<int, String, T?>> updateItem(T item,
      {Future<Result<int, String, T?>> Function(T)? alternativeFunc});
  Future<Result<int, String, T?>> setItem(T item,
      {Future<Result<int, String, T?>> Function(T)? alternativeFunc});
  Future<Result<int, String, List<T>?>> updateCacheRelations(
      {Set<String>? oldRels,
      Set<String>? newRels,
      required String fieldToUpdate,
      required ItemCreator<T> creator});
  Future<Result<int, String, T?>> deleteItem(String id,
      {Future<Result<int, String, T?>> Function(String)? alternativeFunc});
  Future<Result<int, String, List<T>>> getWholeCollection(
      {List<DataFilter>? subCollectionQuery, int limit = 1000});
  Future<void> updateFields(String id, Map<String, dynamic> map);
}
