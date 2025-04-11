import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../../models/iapp_notification.dart';
import 'itheme_service.dart';

class IEventService {
  final BehaviorSubject<AppTheme> _themeSbj = BehaviorSubject();
  final BehaviorSubject<int> _adminTabSbj = BehaviorSubject();
  final BehaviorSubject<int> _userTabSbj = BehaviorSubject();
  final BehaviorSubject<IAppNotification> _notificationSbj = BehaviorSubject();

  void updateTheme(AppTheme theme) => _themeSbj.add(theme);
  Stream<AppTheme> getThemeStream() => _themeSbj.stream;

  void addAdminTabEvent(int index) => _adminTabSbj.add(index);
  Stream<int> getAdminTabStream() => _adminTabSbj.stream;

  void addUserTabEvent(int index) => _userTabSbj.add(index);
  Stream<int> getUserTabStream() => _userTabSbj.stream;

  void addNotifications(IAppNotification event) => _notificationSbj.add(event);
  Stream<IAppNotification> getNotificationStream() => _notificationSbj.stream;
}
