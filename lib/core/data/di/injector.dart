import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/clients/payment_service.dart';
import 'package:masaj/core/data/datasources/device_type_data_source.dart';
import 'package:masaj/core/data/datasources/external_login_data_source.dart';
import 'package:masaj/core/data/datasources/favorites_remote_data_source.dart';
import 'package:masaj/core/data/device/app_info_service.dart';
import 'package:masaj/core/data/device/device_security_service.dart';
import 'package:masaj/core/data/device/launcher_service.dart';
import 'package:masaj/core/data/device/location_helper.dart';
import 'package:masaj/core/data/device/notification_service.dart';
import 'package:masaj/core/data/device/share_service.dart';
import 'package:masaj/core/data/repositories/favorites_repository.dart';
import 'package:masaj/core/data/services/add_to_apple_wallet_service.dart';
import 'package:masaj/core/data/show_case_helper.dart';
import 'package:masaj/features/account/data/datasources/account_remote_data_source.dart';
import 'package:masaj/features/account/data/repositories/account_repository.dart';
import 'package:masaj/features/account/presentation/blocs/about_us_cubit/about_us_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/contact_us_cubit/contact_us_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/coupon_cubit/coupon_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/coupon_details_cubit/coupon_details_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/favorites_cubit/favorites_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/more_tab_cubit/more_tab_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/points_cubit/points_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/topics_cubit/topics_cubit.dart';
import 'package:masaj/features/address/infrastructure/repos/address_repo.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:masaj/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:masaj/features/auth/data/repositories/auth_repository.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/book_service/data/datasources/booking_remote_data_source.dart';
import 'package:masaj/features/book_service/data/repositories/booking_repository.dart';

import 'package:masaj/features/book_service/presentation/blocs/available_therapist_cubit/available_therapist_cubit.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/gifts/data/datasource/gifts_datasource.dart';
import 'package:masaj/features/gifts/data/repo/gifts_repo.dart';
import 'package:masaj/features/gifts/presentaion/bloc/gifts_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/booking_details_cubit/booking_details_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/bookings_tab_cubit/bookings_tab_cubit.dart';
import 'package:masaj/features/home/data/datasources/home_local_data_source.dart';
import 'package:masaj/features/home/data/datasources/home_remote_data_source.dart';
import 'package:masaj/features/home/data/repositories/home_repository.dart';
import 'package:masaj/features/home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/home_page_cubit/home_page_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/home_search_cubit/home_search_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/notificaions_cubit/notifications_cubit.dart';

import 'package:masaj/features/intro/data/datasources/intro_local_data_source.dart';
import 'package:masaj/features/intro/data/repositories/intro_repository.dart';
import 'package:masaj/features/intro/presentation/blocs/choose_language_cubit/choose_language_cubit.dart';
import 'package:masaj/features/intro/presentation/blocs/guide_page_cubit/guide_page_cubit.dart';
import 'package:masaj/features/payment/data/datasource/payment_datasource.dart';
import 'package:masaj/features/payment/data/repo/payment_repo.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';
import 'package:masaj/features/providers_tab/data/datasources/providers_tab_remote_data_source.dart';
import 'package:masaj/features/providers_tab/data/repositories/providers_tab_repository.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/home_therapists_cubit/home_therapists_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/providers_tab_cubit/providers_tab_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/therapist_details_cubit/therapist_details_cubit.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';
import 'package:masaj/features/services/application/service_cubit/service_cubit.dart';
import 'package:masaj/features/services/application/service_details_cubit/service_details_cubit.dart';
import 'package:masaj/features/services/data/datasource/service_datasource.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';
import 'package:masaj/features/members/data/datasource/members_datasource.dart';
import 'package:masaj/features/members/data/repo/members_repo.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';
import 'package:masaj/features/splash/data/datasources/splash_local_data_source.dart';
import 'package:masaj/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:masaj/features/splash/presentation/splash_cubit/splash_cubit.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:masaj/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:masaj/features/wallet/data/repos/wallet_repo_impl.dart';

///Implementing
///
///`Singleton` design pattern
///
///`Flyweight` design pattern
///
///to save specific objects from recreation
class Injector {
  final _flyweightMap = <String, dynamic>{};
  static final _singleton = Injector._internal();

  Injector._internal();

  factory Injector() => _singleton;

  //===================[SPLASH_CUBIT]===================
  SplashCubit get splashCubit => SplashCubit(
      splashRepository: splashRepository,
      notificationService: notificationService,
      deviceSecurityService: deviceSecurityService);

  SplashRepository get splashRepository =>
      _flyweightMap['splashRepository'] ??
      SplashRepositoryImpl(splashLocalDataSource);

  SplashLocalDataSource get splashLocalDataSource =>
      _flyweightMap['splashLocalDataSource'] ??
      SplashLocalDataSourceImpl(cacheService);

  //===================[AUTH_CUBIT]===================
  AuthCubit get authCubit => AuthCubit(
        authRepository: authRepository,
        showCaseHelper: showCaseHelper,
      );

  AuthRepository get authRepository =>
      _flyweightMap['authRepository'] ??= AuthRepositoryImpl(
        authRemoteDataSource,
        authLocalDataSource,
        deviceTypeDataSource,
        notificationService,
        appleExternalDataSource,
        googleExternalDataSource,
      );

  AuthRemoteDataSource get authRemoteDataSource =>
      _flyweightMap['authRemoteDataSource'] ??=
          AuthRemoteDataSourceImpl(networkService);
  ServiceRemoteDataSource get serviceRemoteDataSource =>
      _flyweightMap['serviceRemoteDataSource'] ??=
          ServiceRemoteDataSourceImpl(networkService);

  ServiceRepository get serviceRepository =>
      _flyweightMap['serviceRepository'] ??=
          ServiceRepositoryImpl(serviceRemoteDataSource);

  ServiceCategoryCubit get serviceCategoryCubit =>
      ServiceCategoryCubit(serviceRepository);
  ServiceCubit get serviceCubit => ServiceCubit(serviceRepository);

  ServiceDetailsCubit get serviceDetailsCubit =>
      ServiceDetailsCubit(serviceRepository);

  AuthLocalDataSource get authLocalDataSource =>
      _flyweightMap['authLocalDataSource'] ??=
          AuthLocalDataSourceImpl(cacheService);
  TherapistsDataSource get therapistsDataSource =>
      _flyweightMap['therapistsDataSource'] ??=
          TherapistsDataSourceImpl(networkService);
  TherapistsRepository get providersTabRepository =>
      _flyweightMap['providersTabRepository'] ??= TherapistsRepositoryImpl(
          providers_tabRemoteDataSource: therapistsDataSource);

  //===================[COUNTRY_CUBIT]===================
  CountryCubit get countryCubit => CountryCubit(
        authRepository,
        addressRepo,
      );

  //===================[ADDRESS]===================
  AddressRepo get addressRepo => AddressRepo(
        networkService,
        cacheService,
        locationHelper,
        authLocalDataSource,
      );
  //===================[GUIDE_PAGE_CUBIT]===================
  GuidePageCubit get guidePageCubit => GuidePageCubit(introRepository);

  IntroRepository get introRepository =>
      _flyweightMap['introRepository'] ??
      IntroRepositoryImpl(introLocalDataSource);

  IntroLocalDataSource get introLocalDataSource =>
      _flyweightMap['introLocalDataSource'] ??
      IntroLocalDataSourceImpl(cacheService);

  //===================[CHOOSE_LANGUAGE_CUBIT]===================
  ChooseLanguageCubit get chooseLanguageCubit =>
      ChooseLanguageCubit(introRepository);

  //===================[HOME_CUBIT]===================
  HomeCubit get homeCubit => HomeCubit(
        homeRepository,
        launcherService,
      );

  HomeRepository get homeRepository =>
      _flyweightMap['homeRepository'] ??= HomeRepositoryImpl(
        homeLocalDatasource: homeLocalDatasource,
        homeRemoteDataSource: homeRemoteDataSource,
      );

  HomeRemoteDataSource get homeRemoteDataSource =>
      _flyweightMap['homeRemoteDataSource'] ??=
          HomeRemoteDataSourceImpl(networkService);

  HomeLocalDatasource get homeLocalDatasource =>
      _flyweightMap['homeLocalDatasource'] ??=
          HomeLocalDatasourceImpl(cacheService);

  //===================[ABOUT_US_CUBIT]===================
  AboutUsCubit get aboutUsCubit => AboutUsCubit(accountRepository);

  AccountRepository get accountRepository =>
      _flyweightMap['accountRepository'] ??= AccountRepositoryImpl(
          accountRemoteDataSource: accountRemoteDataSource);

  AccountRemoteDataSource get accountRemoteDataSource =>
      _flyweightMap['accountRemoteDataSource'] ??=
          AccountRemoteDataSourceImpl(networkService);

  //===================[TOPICS_CUBIT]===================
  TopicsCubit get topicsCubit => TopicsCubit(accountRepository);

  //===================[CONTACT_US_CUBIT]===================
  ContactUsCubit get contactUsCubit => ContactUsCubit(accountRepository);

  //===================[MORE_TAB_CUBIT]===================
  MoreTabCubit get moreTabCubit => MoreTabCubit(
        accountRepository: accountRepository,
        launcherService: launcherService,
        appInfoService: appInfoService,
        showCaseHelper: showCaseHelper,
      );

  //===================[FAVORITES_CUBIT]===================

  FavoritesCubit get favoritesCubit => FavoritesCubit(favoritesRepository);

  FavoritesRepository get favoritesRepository =>
      _flyweightMap['favoritesRepository'] ??= FavoritesRepositoryImpl(
          favoritesRemoteDataSource: favoritesRemoteDataSource);

  FavoritesRemoteDataSource get favoritesRemoteDataSource =>
      _flyweightMap['favoritesRemoteDataSource'] ??=
          FavoritesRemoteDataSourceImpl(networkService);
  //===================[Payment_CUBIT]===================

  PaymentService get paymentService =>
      _flyweightMap['PaymentService'] ??= PaymentServiceImpl(networkService);
  PaymentCubit get paymentCubit => PaymentCubit(
      paymentRepository: paymentRepository, paymentService: paymentService);

  PaymentRepository get paymentRepository =>
      _flyweightMap['PaymentRepository'] ??=
          PaymentRepositoryImp(paymentDataSource: paymentDatasource);

  PaymentDataSource get paymentDatasource =>
      _flyweightMap['PaymentDataSource'] ??=
          PaymentDataSourceImpl(networkService: networkService);

  //===================[COUPONS_CUBIT]===================

  CouponCubit get couponCubit => CouponCubit(accountRepository);

  //===================[COUPON_DETAILS_CUBIT]===================

  CouponDetailsCubit get couponDetailsCubit =>
      CouponDetailsCubit(accountRepository);

  //===================[POINTS_CUBIT]===================

  PointsCubit get pointsCubit => PointsCubit(accountRepository);

  //===================[MEMBERS_CUBIT]===================

  MembersCubit get membersCubit =>
      MembersCubit(membersRepository: membersRepository);
  MembersRepository get membersRepository =>
      _flyweightMap['membersRepository'] ??=
          MembersRepositoryImp(membersDataSource: membersRemoteDataSource);
  MembersDataSource get membersRemoteDataSource =>
      _flyweightMap['membersRemoteDataSource'] ??=
          MembersDataSourceImpl(networkService: networkService);

  //===================[BOOKING_CUBIT]===================

  BookingCubit get bookingCubit => BookingCubit(bookingRepository);
  BookingRepository get bookingRepository =>
      _flyweightMap['bookingRepository'] ??=
          BookingRepositoryImpl(bookingRemoteDataSource);
  BookingRemoteDataSource get bookingRemoteDataSource =>
      _flyweightMap['bookingRemoteDataSource'] ??=
          BookingRemoteDataSourceImpl(networkService);
  //===================[WALLET_CUBIT]===================

  WalletBloc get walletCubit => WalletBloc(walletRepository, paymentService);
  WalletRepository get walletRepository => _flyweightMap['WalletRepository'] ??=
      WalletRepositoryImpl(walletDataSource);
  WalletDataSource get walletDataSource => _flyweightMap['WalletDataSource'] ??=
      WalletDataSourceImpl(networkService);
  //===================[GIFTS_CUBIT]===================

  GiftsCubit get giftsCubit => GiftsCubit(
      giftsRepository: giftsRepository, paymentService: paymentService);
  GiftsRepository get giftsRepository => _flyweightMap['GiftsRepository'] ??=
      GiftsRepositoryImp(giftsDataSource: giftsDataSource);
  GiftsDataSource get giftsDataSource => _flyweightMap['GiftsDataSource'] ??=
      GiftsDataSourceImpl(networkService: networkService);

  //===================[NOTIFICATIONS_CUBIT]===================
  NotificationsCubit get notificationsCubit =>
      NotificationsCubit(homeRepository);

  //===================[SEARCH_BLOC]===================

  //===================[CORE_DATA]===================

  DeviceTypeDataSource get deviceTypeDataSource =>
      _flyweightMap['deviceTypeDataSource'] ??= DeviceTypeDataSourceImpl();

  NetworkService get networkService => _flyweightMap['networkService'] ??=
      NetworkServiceImpl(networkServiceUtil, deviceTypeDataSource);

  NetworkServiceUtil get networkServiceUtil =>
      _flyweightMap['networkServiceUtil'] ??=
          NetworkServiceUtilImpl(cacheService);

  CacheService get cacheService =>
      _flyweightMap['cacheService'] ??= CacheServiceImplV2();

  DeviceSecurityService get deviceSecurityService =>
      _flyweightMap['deviceSecurityService'] ??= DeviceSecurityServiceImpl();

  AppInfoService get appInfoService =>
      _flyweightMap['appInfoService'] ??= AppInfoServiceImpl();

  NotificationService get notificationService =>
      _flyweightMap['notificationService'] ??= NotificationService();

  ExternalLoginDataSource get appleExternalDataSource =>
      _flyweightMap['appleExternalDataSource'] ??=
          AppleExternalLoginDataSourceImpl();

  ExternalLoginDataSource get googleExternalDataSource =>
      _flyweightMap['googleExternalDataSource'] ??=
          GoogleExternalLoginDataSourceImpl();

  LauncherService get launcherService =>
      _flyweightMap['launcherService'] ??= LauncherServiceImpl();

  ShareService get shareService =>
      _flyweightMap['shareService'] ??= ShareServiceImpl();

  DeviceLocation get locationHelper =>
      _flyweightMap['locationHelper'] ??= DeviceLocationImpl();

  ShowCaseHelper get showCaseHelper =>
      _flyweightMap['showCaseHelper'] ??= ShowCaseHelper(cacheService);

  AddToAppleWalletService get addToAppleWalletService =>
      _flyweightMap['addToAppleWalletService'] ??=
          AddToAppleWalletServiceImpl();
  ProvidersTabCubit get providersTabCubit => ProvidersTabCubit(
        providersTabRepository: providersTabRepository,
      );

  BookingsTabCubit get bookingsTabCubit => BookingsTabCubit(
        bookingsTabRepository: bookingRepository,
      );
  BookingDetailsCubit get bookingDetailsCubit =>
      BookingDetailsCubit(bookingRepository);
  AvialbleTherapistCubit get avialbleTherapistCubit => AvialbleTherapistCubit(
        providersTabRepository: providersTabRepository,
      );
  HomeTherapistsCubit get homeTherapistsCubit => HomeTherapistsCubit(
        providersTabRepository,
      );
  TherapistDetailsCubit get therapistDetailsCubit => TherapistDetailsCubit(
        providersTabRepository,
      );
  HomeSearchCubit get homeSearchCubit => HomeSearchCubit(
        homeRepository: homeRepository,
      );
  HomePageCubit get homePageCubit => HomePageCubit(
        homeRepository,
        serviceRepository,
        bookingRepository,
      );
}
