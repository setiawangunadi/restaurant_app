import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_app/config/data/handler/notification_helper.dart';
import 'package:restaurant_app/routers.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    final NotificationHelper notificationHelper = NotificationHelper();
    await notificationHelper.initNotification(flutterLocalNotificationsPlugin);
    notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);
    tz.initializeTimeZones();
  } else if (status.isDenied) {
    debugPrint("DENIED PERMISSION NOTIF");
  } else if (status.isPermanentlyDenied) {
    debugPrint("SET MANUALLY PERMISSION NOTIF");
    openAppSettings();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routers.home,
      routes: Routers().route,
    );
  }
}
