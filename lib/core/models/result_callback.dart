import 'package:flutter/foundation.dart';

class CallbackInvocation {}

class ResultCallback<T> {
  final CallbackInvocation Function() onLoading;
  final CallbackInvocation Function(String error, [dynamic details]) onError;
  final CallbackInvocation Function(T) onData;

  ResultCallback({
    required this.onLoading,
    required this.onError,
    required this.onData,
  });
}

class DebugCallback<T> extends ResultCallback<T> {

  DebugCallback() : super(
      onLoading: () {
        debugPrint("loading");
        return CallbackInvocation();
      },
      onError: (message, [details]) {
        debugPrint("error: $message");
        return CallbackInvocation();
      },
      onData: (data) {
        debugPrint("data: $data");
        return CallbackInvocation();
      }
  );
}