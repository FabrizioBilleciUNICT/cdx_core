
import 'dart:async';
import 'dart:ui';
import 'handler.dart';

class DebounceHandler implements ITimedEventHandler {
  final int milliseconds;
  Timer? _timer;

  DebounceHandler(this.milliseconds);

  @override
  void execute(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  @override
  void reset() {
    _timer?.cancel();
    _timer = null;
  }
}