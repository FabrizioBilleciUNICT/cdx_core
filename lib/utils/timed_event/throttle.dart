
import 'dart:ui';
import 'handler.dart';

class ThrottleHandler implements ITimedEventHandler {
  final int milliseconds;
  bool _isThrottled = false;

  ThrottleHandler(this.milliseconds);

  @override
  void execute(VoidCallback action) {
    if (!_isThrottled) {
      action();
      _isThrottled = true;
      Future.delayed(Duration(milliseconds: milliseconds), () {
        _isThrottled = false;
      });
    }
  }

  @override
  void reset() {
    _isThrottled = false;
  }
}
