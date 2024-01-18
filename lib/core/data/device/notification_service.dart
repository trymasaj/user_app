import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_apns_only/flutter_apns_only.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:masaj/core/data/typedefs/type_defs.dart';
import 'package:masaj/core/data/io/url_helper.dart';

class NotificationService {
  late final _connector = ApnsPushConnectorOnly();
  Future<void> inti() async {
    await _FlutterLocalNotificationHelper.init();
    if (Platform.isIOS) {
      _initIOS();
    } else {
      await _initAndroid();
    }
    try {
      await getDeviceTokenId();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  void _initIOS([FutureCallback? onReceiveNewNotification]) {
    _connector.configureApns(
      onLaunch: _openNotificationsPageIfAppOpenedFromTerminatedIos,
      onMessage: (iosNotification) {
        if (onReceiveNewNotification != null) onReceiveNewNotification();
        return _FlutterLocalNotificationHelper.showFCMNotification(
          title: iosNotification.payload['notification']['title'],
          body: iosNotification.payload['notification']['body'],
          image: iosNotification.payload['data']['image'],
        );
      },
      onResume: (iosNotification) async {
        if (onReceiveNewNotification != null) onReceiveNewNotification();
        // return navigateToNotificationPage(
        //     iosNotification.payload['data']['notificationId']);
      },
    );
  }

  Future<void> _initAndroid([FutureCallback? onReceiveNewNotification]) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (onReceiveNewNotification != null) onReceiveNewNotification();

      final notification = message.notification;
      final android = message.notification?.android;
      final image = message.data['image'];

      if (notification != null && android != null) {
        _FlutterLocalNotificationHelper.showFCMNotification(
          title: notification.title,
          body: notification.body,
          image: image,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      if (onReceiveNewNotification != null) onReceiveNewNotification();
      // navigateToNotificationPage(
      //     int.tryParse(notification.data['notificationId'].toString()));
    });

    await _openNotificationsPageIfAppOpenedFromTerminatedAndroid();
  }

  static Future<void>
      _openNotificationsPageIfAppOpenedFromTerminatedAndroid() async {
    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await Future.delayed(const Duration(milliseconds: 500));
      // navigateToNotificationPage(
      //     int.tryParse(notification.data['notificationId'].toString()));
    }
  }

  static Future<void> _openNotificationsPageIfAppOpenedFromTerminatedIos(
      ApnsRemoteMessage iosNotification) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // navigateToNotificationPage(
    //     iosNotification.payload['data']['notificationId']);
  }

  Future<String> getDeviceTokenId() async {
    if (Platform.isIOS) {
      _connector.requestNotificationPermissions();
      final token = _connector.token.value;
      return token ?? '';
    } else if (Platform.isAndroid) {
      final messaging = FirebaseMessaging.instance;
      final token = await messaging.getToken();
      return token!;
    } else
      throw Exception('Not supported platform');
  }

  Future<void> cancelAll() => _FlutterLocalNotificationHelper.cancelAll();
}

class _FlutterLocalNotificationHelper {
  static const channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  static Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    flutterLocalNotificationsPlugin!.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  static Future<void> showFCMNotification({
    String? title,
    String? body,
    required String? image,
  }) async {
    final imagePath = image == null ? null : await _downloadAndSaveFile(image);

    return flutterLocalNotificationsPlugin!.show(
      const _NotificationIdGenerator().generate(),
      title,
      body,
      NotificationDetails(
        iOS: imagePath == null
            ? null
            : DarwinNotificationDetails(
                attachments: [DarwinNotificationAttachment(imagePath)]),
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          priority: Priority.max,
          importance: Importance.max,
          largeIcon:
              imagePath == null ? null : FilePathAndroidBitmap(imagePath),
        ),
      ),
    );
  }

  static Future<void> cancelAll() async =>
      flutterLocalNotificationsPlugin?.cancelAll();

  static Future<String> _downloadAndSaveFile(String url) async {
    final urlHelper = UrlHelper();
    final fileName = urlHelper.getFileName(url);
    final fileExtension = urlHelper.getFileExtension(url);

    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName.$fileExtension';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

Future<void> navigateToNotificationPage([int? notificationId]) async {
  if (notificationId == null) return Future.value();
  // return navigatorKey.currentState!.push(
  //   MaterialPageRoute(
  //     builder: (context) =>
  //         NotificationDetailsView(notificationId: notificationId),
  //     settings: const RouteSettings(name: NotificationDetailsView.routeName),
  //   ),
  // );
}

class _NotificationIdGenerator {
  const _NotificationIdGenerator();

  static final random = math.Random();

  int generate() => random.nextInt(math.pow(2, 31).toInt() - 1);
}
