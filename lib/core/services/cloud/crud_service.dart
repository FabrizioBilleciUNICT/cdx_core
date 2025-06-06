import 'package:rxdart/rxdart.dart';
import 'package:cdx_core/utils/extensions.dart';
import '../../models/filter_wrapper.dart';
import '../../models/result.dart';
import '../../models/base_object.dart';
import 'icrud_service.dart';
import '../cloud_platform/idatabase_platform.dart';

/// Strategy interface to configure CRUD behavior (pushNullFirst and forceUpdate).
abstract class CrudStrategy {
  bool get pushNullFirst;
  bool get forceUpdate;
}

/// Default implementation of CrudStrategy.
class DefaultCrudStrategy implements CrudStrategy {
  final bool _pushNullFirst;
  final bool _forceUpdate;

  const DefaultCrudStrategy({bool pushNullFirst = false, bool forceUpdate = false})
      : _pushNullFirst = pushNullFirst,
        _forceUpdate = forceUpdate;

  @override
  bool get pushNullFirst => _pushNullFirst;

  @override
  bool get forceUpdate => _forceUpdate;
}


/// Strategy: PushNullFirst = false, ForceUpdate = false.
class NoPushNoForceStrategy implements CrudStrategy {
  const NoPushNoForceStrategy();
  @override
  bool get pushNullFirst => false;
  @override
  bool get forceUpdate => false;
}

/// Strategy: PushNullFirst = true, ForceUpdate = false.
class PushNullFirstStrategy implements CrudStrategy {
  const PushNullFirstStrategy();
  @override
  bool get pushNullFirst => true;
  @override
  bool get forceUpdate => false;
}

/// Strategy: PushNullFirst = false, ForceUpdate = true.
class ForceUpdateStrategy implements CrudStrategy {
  const ForceUpdateStrategy();
  @override
  bool get pushNullFirst => false;
  @override
  bool get forceUpdate => true;
}

/// Strategy: PushNullFirst = true, ForceUpdate = true.
class PushNullFirstAndForceUpdateStrategy implements CrudStrategy {
  const PushNullFirstAndForceUpdateStrategy();
  @override
  bool get pushNullFirst => true;
  @override
  bool get forceUpdate => true;
}

/// Refactored CrudService with support for multiple channels and method-level strategy.
class CrudService<T extends BaseObject> implements ICrudService<T> {
  late final IDatabasePlatform<T> _crud;
  final int Function(T a, T b)? sortFunc;

  // Streams for individual item, result, and list, keyed by channel. 'main' is the default channel.
  final Map<String, BehaviorSubject<T?>> _itemStreams = {
    'main': BehaviorSubject<T?>()
  };
  final Map<String, BehaviorSubject<Result<int, String, T?>>> _resultStreams = {
    'main': BehaviorSubject<Result<int, String, T?>>()
  };
  final Map<String, BehaviorSubject<List<T>>> _itemsStreams = {
    'main': BehaviorSubject<List<T>>()
  };

  IDatabasePlatform<T> get crud => _crud;

  CrudService({
    required IDatabasePlatform<T> databasePlatform,
    this.sortFunc,
  }) {
    _crud = databasePlatform;
  }

  // Helper method to get or create the item stream for a given channel.
  BehaviorSubject<T?> _getItemStream(String channel) =>
      _itemStreams.putIfAbsent(channel, () => BehaviorSubject<T?>());

  // Helper method to get or create the items stream for a given channel.
  BehaviorSubject<List<T>> _getItemsStream(String channel) =>
      _itemsStreams.putIfAbsent(channel, () => BehaviorSubject<List<T>>());

  // Helper method to get or create the result stream for a given channel.
  BehaviorSubject<Result<int, String, T?>> _getResultStream(String channel) =>
      _resultStreams.putIfAbsent(
          channel, () => BehaviorSubject<Result<int, String, T?>>());

  Result<int, String, T?> get _nullResult => Result(code: 0, message: '', data: null);
  Result<int, String, T?> _dataResult(T? data) => Result(code: 0, message: '', data: data);
  Result<int, String, List<T>> _listResult(List<T> data) => Result(code: 0, message: '', data: data);
  List<T> _currentList(String channel) => _getItemsStream(channel).valueOrNull ?? [];

  @override
  Future<Result<int, String, T?>> createItem(
      T item, {
        Future<Result<int, String, T?>> Function(T)? alternativeFunc,
        String channel = 'main',
      }) async {
    final res = await (alternativeFunc != null
        ? alternativeFunc(item)
        : _crud.createItem(item));
    if (res.code == 0) {
      final createdItem = res.data!;
      _getItemStream(channel).add(createdItem);
      final currentList = _currentList(channel);
      final updatedList = [...currentList, createdItem];
      _getItemsStream(channel).add(updatedList);
    }
    return res;
  }

  @override
  Future<Result<int, String, T?>> deleteItem(
      String id, {
        Future<Result<int, String, T?>> Function(String)? alternativeFunc,
        String channel = 'main',
      }) async {
    final res = await (alternativeFunc != null
        ? alternativeFunc(id)
        : _crud.deleteItem(id));
    if (res.code == 0) {
      final currentList = _currentList(channel);
      final updatedList = currentList.where((e) => e.id != id).toList();
      _getItemsStream(channel).add(updatedList);
    }
    return res;
  }

  @override
  Future<Result<int, String, T?>> getItem({
    String? id,
    Future<Result<int, String, T?>> Function()? alternativeFunc,
    dynamic docRef,
    String channel = 'main',
    CrudStrategy strategy = const DefaultCrudStrategy(),
  }) async {
    // Emit null first if the strategy requires it.
    if (strategy.pushNullFirst) {
      _getResultStream(channel).add(_nullResult);
      _getItemStream(channel).add(null);
    }
    // Return cached item if available and forceUpdate is not required.
    final cachedItems = _currentList(channel);
    if (!strategy.forceUpdate && cachedItems.isNotEmpty) {
      final item = cachedItems.cast<T?>().firstWhere((e) => e?.id == id, orElse: () => null);
      if (item != null) {
        _getItemStream(channel).add(item);
        final list = _updatedList(channel, item);
        _getItemsStream(channel).add(list);
        final foundResult = _dataResult(item);
        _getResultStream(channel).add(foundResult);
        return foundResult;
      }
    }
    // Fetch item from the remote source.
    final res = await (alternativeFunc != null
        ? alternativeFunc()
        : _crud.getItem(id: id, docRef: docRef));
    if (res.code == 0) {
      final fetchedItem = res.data!;
      _getItemStream(channel).add(fetchedItem);
      final list = _updatedList(channel, fetchedItem);
      _getItemsStream(channel).add(list);
    }
    _getResultStream(channel).add(res);
    return res;
  }

  @override
  Future<Result<int, String, T?>> itemWhere({
    required List<DataFilter> query,
    required T? Function(List<T>) choiceFunction,
    String channel = 'main',
    CrudStrategy strategy = const DefaultCrudStrategy(),
  }) async {
    if (strategy.pushNullFirst) {
      _getResultStream(channel).add(_nullResult);
      _getItemStream(channel).add(null);
    }
    final res = await _crud.getItems(subCollectionQuery: query);
    if (res.code == 0 && res.data != null) {
      final items = res.data!;
      final T? item = choiceFunction(items);
      _getItemStream(channel).add(item);
      final list = _updatedList(channel, item);
      _getItemsStream(channel).add(list);
      final newResult = _dataResult(item);
      _getResultStream(channel).add(newResult);
      return newResult;
    }
    _getResultStream(channel).add(_nullResult);
    return _nullResult;
  }

  List<T> _updatedList(String channel, T? item) {
    if (item == null) return _currentList(channel);
    return ([..._currentList(channel), item]).uniques((e) => e.id);
  }

  @override
  Future<Result<int, String, List<T>>> getItems({
    bool getCount = false,
    Future<Result<int, String, List<T>>> Function()? alternativeFunc,
    List<DataFilter>? subCollectionQuery,
    bool? useCursor,
    int limit = 1000,
    String channel = 'main',
    CrudStrategy strategy = const DefaultCrudStrategy(),
    List<OrderBy>? orderBy
  }) async {
    final currentItems = _currentList(channel);
    if (strategy.pushNullFirst) {
      _getItemsStream(channel).add([]);
    }
    if (!strategy.forceUpdate &&
        currentItems.isNotEmpty &&
        (currentItems.length != 1 ||
            currentItems[0].id != _getItemStream(channel).valueOrNull?.id)) {
      final items = currentItems;
      if (sortFunc != null) items.sort(sortFunc);
      _getItemsStream(channel).add(items);
      return _listResult(items);
    }
    final res = await (alternativeFunc != null
        ? alternativeFunc()
        : _crud.getItems(
        subCollectionQuery: subCollectionQuery,
        useCursor: useCursor,
        getCount: getCount,
        limit: limit,
        orderBy: orderBy
    ));
    if (res.code == 0) {
      final items = res.data!;
      if (sortFunc != null) items.sort(sortFunc);
      _getItemsStream(channel).add(items);
    }
    return res;
  }

  @override
  Future<Result<int, String, List<T>>> getWholeCollection({
    List<DataFilter>? subCollectionQuery,
    int limit = 1000,
    String channel = 'main',
    CrudStrategy strategy = const DefaultCrudStrategy(),
  }) async {
    final res = await _crud.getWholeCollection(
      currentCount: _currentList(channel).length,
      subCollectionQuery: subCollectionQuery,
      limit: limit,
    );
    if (res.code == 0) {
      final items = res.data!;
      _getItemsStream(channel).add(items);
      return res;
    } else {
      final items = _currentList(channel);
      _getItemsStream(channel).add(items);
      return _listResult(items);
    }
  }

  @override
  Future<Result<int, String, T?>> updateItem(
      T item, {
        Future<Result<int, String, T?>> Function(T item)? alternativeFunc,
        String channel = 'main',
        CrudStrategy strategy = const DefaultCrudStrategy(),
      }) async {
    final res = await (alternativeFunc != null
        ? alternativeFunc(item)
        : _crud.updateItem(item));
    if (res.code == 0) {
      final updatedItem = res.data!;
      _getItemStream(channel).add(updatedItem);
      var items = _currentList(channel);
      final index = items.indexWhere((e) => e.id == updatedItem.id);
      if (index != -1) {
        items.replaceRange(index, index + 1, [updatedItem]);
      }
      _getItemsStream(channel).add(items);
    }
    return res;
  }

  @override
  Future<Result<int, String, T?>> setItem(
      T item, {
        Future<Result<int, String, T?>> Function(T item)? alternativeFunc,
        String channel = 'main',
        CrudStrategy strategy = const DefaultCrudStrategy(),
      }) async {
    final res = await (alternativeFunc != null
        ? alternativeFunc(item)
        : _crud.setItem(item));
    if (res.code == 0) {
      final setItem = res.data!;
      _getItemStream(channel).add(setItem);
      var items = _currentList(channel);
      final index = items.indexWhere((e) => e.id == setItem.id);
      if (index > -1) {
        items.replaceRange(index, index + 1, [setItem]);
      } else {
        items.add(setItem);
      }
      _getItemsStream(channel).add(items);
    }
    return res;
  }

  @override
  Future<Result<int, String, List<T>?>> updateCacheRelations({
    Set<String>? oldRels,
    Set<String>? newRels,
    required String fieldToUpdate,
    required ItemCreator<T> creator,
    String channel = 'main',
    CrudStrategy strategy = const DefaultCrudStrategy(),
  }) async {
    final Set<String> relsToAdd = {};
    final Set<String> relsToRemove = {};

    final allRels = <String>{...?oldRels, ...?newRels};
    for (final r in allRels) {
      if (newRels?.contains(r) == true) {
        relsToAdd.add(r);
      }
      if (oldRels?.contains(r) == true) {
        relsToRemove.add(r);
      }
    }

    final items = _currentList(channel);
    final updatedItems = items.map((e) {
      final map = e.toJson();
      final shouldIncrement = relsToAdd.contains(e.id);
      final shouldDecrement = relsToRemove.contains(e.id);
      if (shouldIncrement && !shouldDecrement) {
        map[fieldToUpdate] = (map[fieldToUpdate] ?? 0) + 1;
      } else if (shouldDecrement && !shouldIncrement) {
        map[fieldToUpdate] = (map[fieldToUpdate] ?? 1) - 1;
      }
      return creator(map);
    }).toList();

    _getItemsStream(channel).add(updatedItems);
    return _listResult(updatedItems);
  }

  @override
  ValueStream<T?> itemStream({String channel = 'main'}) {
    return _getItemStream(channel).stream;
  }

  @override
  ValueStream<Result<int, String, T?>> resultStream({String channel = 'main'}) {
    return _getResultStream(channel).stream;
  }

  @override
  ValueStream<List<T>> itemsStream({String channel = 'main'}) {
    return _getItemsStream(channel).stream;
  }

  @override
  Future<void> updateFields(String id, Map<String, dynamic> map) {
    return _crud.updateFields(id, map);
  }
}
