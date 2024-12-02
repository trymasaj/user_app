import 'dart:async';
import 'dart:isolate';
// import 'package:adjust_sdk/adjust.dart';
// import 'package:adjust_sdk/adjust_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:masaj/core/data/device/notification_service.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
// import 'package:masaj/core/data/services/adjsut.dart';
import 'package:masaj/core/presentation/routes/routes.dart';
import 'package:masaj/core/presentation/size/size_utils.dart';
import 'package:masaj/core/presentation/theme/theme_helper.dart';
import 'package:masaj/features/account/presentation/blocs/favorites_cubit/favorites_cubit.dart';
import 'package:masaj/features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/home_page_cubit/home_page_cubit.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/home_therapists_cubit/home_therapists_cubit.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';
import 'package:masaj/features/splash/presentation/pages/splash_page.dart';
import 'package:masaj/features/splash/presentation/splash_cubit/splash_cubit.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:masaj/firebase_options.dart';
import 'package:upgrader/upgrader.dart';
var eventBus = EventBus();
void main() async {
  runZonedGuarded<Future<void>>(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

    await EasyLocalization.ensureInitialized();
    setup();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initCrashLytics();
    await DI.find<NotificationService>().init();

    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // AdjustConfig config =
    //     new AdjustConfig('H_KKW6jVtGv1B9s-BLph', AdjustEnvironment.production);
    // Adjust.start(config);
    // AdjustTracker.initialize('H_KKW6jVtGv1B9s-BLph');

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: RequestsInspector(
          navigatorKey: navigatorKey,
          enabled: BUILD_TYPE != BuildType.release,
          showInspectorOn: ShowInspectorOn.LongPress,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => DI.find<SplashCubit>()..init()),
              BlocProvider(create: (context) => DI.find<AuthCubit>()..init()),
              BlocProvider(create: (context) => DI.find<FavoritesCubit>()),
              BlocProvider(create: (context) => DI.find<CountryCubit>()),
              BlocProvider(create: (context) => DI.find<MembersCubit>()),
              BlocProvider(
                  create: (context) => DI.find<HomeCubit>()..loadHome()),
              BlocProvider(create: (context) => DI.find<HomePageCubit>()),
              BlocProvider(create: (context) => DI.find<WalletBloc>()),
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

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeLanguage(newLocale);
  }

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
      final notificationService = DI.find<NotificationService>();
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

  Locale? _locale;
  void changeLanguage(Locale locale) {
     setState(() {
      _locale = locale;
     });
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
                BlocProvider<ServiceCategoryCubit>(
                    create: (context) => DI.find<ServiceCategoryCubit>()),
                BlocProvider<HomeTherapistsCubit>(
                    lazy: true,
                    create: (context) => DI.find<HomeTherapistsCubit>()),
                BlocProvider(
                    create: (context) =>
                        DI.find<MyAddressesCubit>()..getAddresses()),
                BlocProvider(
                    lazy: false, create: (context) => DI.find<BookingCubit>()),
              ],
              child: UpgradeAlert(
                barrierDismissible: true,
                shouldPopScope: () => true,
                upgrader: Upgrader(
                  storeController: UpgraderStoreController(
                    onAndroid: () => UpgraderPlayStore(),
                    oniOS: () => UpgraderAppStore(),
                  ),
                ),
                child: LoaderOverlay(
                  closeOnBackButton: true,
                  child: MaterialApp(
                    onGenerateRoute: onGenerateRoute,
                    home: const SplashPage(),
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: _locale ?? context.locale,
                    debugShowCheckedModeBanner: false,
                    theme: theme,
                    scrollBehavior: const MaterialScrollBehavior().copyWith(
                      physics: const ClampingScrollPhysics(),
                    ),
                    title: 'Masaj',
                    navigatorKey: navigatorKey,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

enum BuildType {debug, test, release}
const BuildType BUILD_TYPE = BuildType.debug;