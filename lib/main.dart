import 'dart:async';
import 'dart:isolate';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/routes/routes.dart';
import 'package:masaj/core/presentation/size/size_utils.dart';
import 'package:masaj/core/presentation/theme/theme_helper.dart';
import 'package:masaj/features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart';
import 'package:masaj/features/splash/presentation/pages/splash_page.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:masaj/firebase_options.dart';

///Don't forget to change it in release!!
const isRelease = false;
const inspectorEnabled = true;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    configureDependencies();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initCrashLytics();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: RequestsInspector(
          navigatorKey: navigatorKey,
          enabled: inspectorEnabled,
          showInspectorOn: ShowInspectorOn.LongPress,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => Injector().splashCubit..init()),
              BlocProvider(create: (context) => Injector().authCubit..init()),
              BlocProvider(create: (context) => Injector().favoritesCubit),
              BlocProvider(create: (context) => Injector().countryCubit),
              BlocProvider(create: (context) => Injector().membersCubit),
              BlocProvider(
                  create: (context) => Injector().homeCubit..loadHome()),
              BlocProvider(create: (context) => Injector().homePageCubit),
              BlocProvider(
                create: (context) =>
                    Injector().membershipCubit..getSubscription(),
                lazy: false,
              ),
              BlocProvider(
                  create: (context) =>
                      Injector().walletCubit..getWalletBalance()),
              BlocProvider(
                  lazy: false,
                  create: (context) =>
                      Injector().medicalFormBloc..getConditions())
            ],
            child: const MyApp(),
          ),
        ),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });
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
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
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
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) =>
                        getIt<MyAddressesCubit>()..getAddresses()),
                BlocProvider(
                    lazy: false, create: (context) => Injector().bookingCubit),
              ],
              child: MaterialApp(
                onGenerateRoute: onGenerateRoute,
                home: const SplashPage(),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: theme,
                scrollBehavior: const MaterialScrollBehavior().copyWith(
                  physics: const ClampingScrollPhysics(),
                ),
                title: 'Masaj',
                navigatorKey: navigatorKey,
              ),
            );
          }),
        ),
      ),
    );
  }
}
