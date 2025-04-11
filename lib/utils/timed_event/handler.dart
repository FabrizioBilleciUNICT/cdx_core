
import 'dart:ui';

abstract class ITimedEventHandler {
  void execute(VoidCallback action);
  void reset();
}