abstract class IBaseObject {
  String? id;
  String get mappedName => '';

  Map<String, dynamic> toJson();
  IBaseObject fromJson(Map<String, dynamic> json);
  IBaseObject mergeObject(IBaseObject? item);
}
