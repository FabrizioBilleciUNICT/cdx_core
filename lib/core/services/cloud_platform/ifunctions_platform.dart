import '../../models/base_object.dart';
import '../../models/result.dart';

abstract class IFunctionsPlatform {
  Future<Result<int, String, T?>> callFunction<T extends BaseObject>(
      String func,
      {Map<String, dynamic> parameters = const {},
      required T? Function(Map<String, dynamic>?) conversion});
}
