// import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationApi {


  final FlutterLocalNotificationsPlugin _notification = FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin getPlugin() {
    notificationService();
    return _notification;
  }

  Future<void> notificationService() async {


    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
    );


    await _notification.initialize(
      initializationSettings,
    );

    await _initializeTime();

    }

  NotificationDetails getPCS() {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    return platformChannelSpecifics;

  }

  Future<void> _initializeTime() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
    print(timeZoneName);
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 14);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
      print("un dia agregado");
    }
    commonNotifications(0, "title1", "body1");
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfMondayOrThursdayTwoPM() {
    tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
    switch (scheduledDate.weekday){
      case DateTime.monday: {

      }
      break;
      case DateTime.tuesday: {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      break;
      case DateTime.wednesday: {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      break;
      case DateTime.thursday: {

      }
      break;
      case DateTime.friday: {
        scheduledDate = scheduledDate.add(const Duration(days: 1));

      }
      break;
      case DateTime.saturday: {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      break;
      case DateTime.sunday: {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      break;
    }
    print(scheduledDate.weekday);
    return scheduledDate;
  }

  Future<void> showScheduleNotification(
      int id,
      String title,
      String body,

      ) async {
        notificationService();
        _notification.zonedSchedule(
            id,
            '$title',
            '$body',
            _nextInstanceOfMondayOrThursdayTwoPM(),
            const NotificationDetails(
                android: AndroidNotificationDetails(
                    'schedule id', 'schedule name',
                    channelDescription: 'schedule description')),
            androidAllowWhileIdle: true,
            uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);

  }

  commonNotifications(
      int id,
      String title,
      String body,
      ) {
    notificationService();
    _notification.show(id, title, body, getPCS());
  }

}

