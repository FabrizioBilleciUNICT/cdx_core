import 'ibase_object.dart';

typedef Constructor<T> = T Function();

abstract class BaseObject implements IBaseObject {
  @override
  IBaseObject mergeObject(IBaseObject? item) {
    if (item == null) return this;

    Map<String, dynamic> thisUserMap = toJson();
    Map<String, dynamic> mergeUserMap = item.toJson();

    thisUserMap.forEach((key, value) {
      if (mergeUserMap[key] != null) {
        if (mergeUserMap[key] is String) {
          if ((mergeUserMap[key] as String).isNotEmpty) {
            thisUserMap[key] = mergeUserMap[key];
          }
        } else {
          thisUserMap[key] = mergeUserMap[key];
        }
      }
    });

    return fromJson(thisUserMap);
  }
}
