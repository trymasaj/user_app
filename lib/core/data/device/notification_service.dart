import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:masaj/core/data/io/url_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:injectable/injectable.dart';

typedef FutureCallback<T> = FutureOr<T> Function();
typedef FutureCallbackWithData<T, V> = FutureOr<T> Function(V data);
typedef FutureValueChanged<T> = FutureOr<void> Function(T);

@singleton
class NotificationService {
  Future<void> init() async {
    await _FlutterLocalNotificationHelper.init();

    await _init();

    try {
      final deviceTokenId = await getDeviceTokenId();
      await cancelAll();
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> _init([FutureCallback? onReceiveNewNotification]) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (onReceiveNewNotification != null) onReceiveNewNotification();

      final notification = message.notification;
      final image = message.data['image'];

      if (notification != null)
        _FlutterLocalNotificationHelper.showFCMNotification(
          title: notification.title,
          body: notification.body,
          image: image,
        );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      if (onReceiveNewNotification != null) onReceiveNewNotification();
      // navigateToNotificationPage(
      //     int.tryParse(notification.data['notificationId'].toString()));
    });

    // await _openNotificationsPageIfAppOpenedFromTerminated();
  }

  // static Future<void> _openNotificationsPageIfAppOpenedFromTerminated() async {
  //   final notification = await FirebaseMessaging.instance.getInitialMessage();
  //   if (notification != null) {
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     // navigateToNotificationPage(
  //     //     int.tryParse(notification.data['notificationId'].toString()));
  //   }
  // }

  Future<String> getDeviceTokenId() async {
    //TODO: we need to rempove this try catch and improve error handling
    try {
      if (Platform.isIOS || Platform.isAndroid) {
        await _requestPermission();

        final messaging = FirebaseMessaging.instance;
        final token = await messaging.getToken();
        return token!;
      } else {
        throw Exception('Not supported platform');
      }
    } on Exception catch (e) {
      return '';
    }
  }

  Future<void> _requestPermission() async {
    final notificationSettings =
        await FirebaseMessaging.instance.requestPermission();

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.denied) {
      log('User denied permission');
    }
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

    if (Platform.isAndroid) {
/*
      flutterLocalNotificationsPlugin!
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
*/
    }

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
