import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masaj/core/utils/size_utils.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/intro/presentation/pages/quiz/quiz_page.dart';
import 'package:masaj/features/intro/presentation/pages/quiz/quiz_start_page.dart';
import 'package:masaj/features/splash/presentation/pages/splash_page.dart';
import 'package:masaj/res/theme/theme_helper.dart';

import 'di/injector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'res/style/theme.dart';
import 'routes/routes.dart';

///Don't forget to change it in release!!
const isRelease = false;
const inspectorEnabled = true;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    //await _initCrashLytics();
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'lib/res/translations',
        fallbackLocale: const Locale('en'),
        child: RequestsInspector(
          enabled: inspectorEnabled,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => Injector().authCubit..init()),
              BlocProvider(create: (context) => Injector().favoritesCubit),
              //   BlocProvider(create: (context) => Injector().treasureHuntCubit),
            ],
            child: const MyApp(),
          ),
        ),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

Future<void> _initCrashLytics() async {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);
  if (kDebugMode)
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final notificationService = Injector().notificationService;
      await Future.wait([
        notificationService.cancelAll(),
        notificationService.getDeviceTokenId(),
      ]);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    final isArabic = context.locale == const Locale('ar');
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Sizer(
        builder: (context, orientation, deviceType) => ScreenUtilInit(
          designSize: const Size(375, 790),
          minTextAdapt: true,
          child: Builder(builder: (context) {
            return MaterialApp(
              home: QuizStartPage(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: theme,
              //Adding ClampingScrollPhysics() to avoid over scrolling in the app
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                physics: const ClampingScrollPhysics(),
              ),
              title: 'Masaj',
              routes: routes,
              navigatorKey: navigatorKey,
            );
          }),
        ),
      ),
    );
  }
}
