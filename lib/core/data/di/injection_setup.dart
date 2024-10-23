import 'package:masaj/core/data/clients/cache_manager.dart';
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
import 'package:masaj/core/data/logger/logger_lib.dart';
import 'package:masaj/core/data/repositories/countries_repo_impl.dart';
import 'package:masaj/core/data/repositories/favorites_repository.dart';
import 'package:masaj/core/data/services/add_to_apple_wallet_service.dart';
import 'package:masaj/core/data/show_case_helper.dart';
import 'package:masaj/core/domain/repos/countries_repo.dart';
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
import 'package:masaj/features/address/application/blocs/add_new_address_bloc/update_address_bloc.dart';
import 'package:masaj/features/address/application/blocs/map_location_picker_cubit/map_location_picker_cubit.dart';
import 'package:masaj/features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart';
import 'package:masaj/features/address/application/blocs/select_location_bloc/select_location_bloc.dart';
import 'package:masaj/features/address/infrastructure/repos/address_repo.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:masaj/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:masaj/features/auth/data/managers/auth_manager.dart';
import 'package:masaj/features/book_service/data/datasources/booking_remote_data_source.dart';
import 'package:masaj/features/book_service/data/repositories/booking_repository.dart';
import 'package:masaj/features/book_service/presentation/blocs/available_therapist_cubit/available_therapist_cubit.dart';
import 'package:masaj/features/book_service/presentation/blocs/book_cubit/book_service_cubit.dart';
import 'package:masaj/features/bookings_tab/data/datasources/review_remote_data_source.dart';
import 'package:masaj/features/bookings_tab/data/repositories/review_repository.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/booking_details_cubit/booking_details_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/bookings_tab_cubit/bookings_tab_cubit.dart';
import 'package:masaj/features/bookings_tab/presentation/cubits/review_tips_cubit/review_tips_cubit.dart';
import 'package:masaj/features/gifts/data/datasource/gifts_datasource.dart';
import 'package:masaj/features/gifts/data/repo/gifts_repo.dart';
import 'package:masaj/features/gifts/presentaion/bloc/gifts_cubit.dart';
import 'package:masaj/features/home/data/datasources/home_local_data_source.dart';
import 'package:masaj/features/home/data/datasources/home_remote_data_source.dart';
import 'package:masaj/features/home/data/datasources/notifications_remote_datasource.dart';
import 'package:masaj/features/home/data/repositories/home_repository.dart';
import 'package:masaj/features/home/data/repositories/notifications_repository.dart';
import 'package:masaj/features/home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/home_page_cubit/home_page_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/home_search_cubit/home_search_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/notificaions_cubit/notifications_cubit.dart';
import 'package:masaj/features/intro/presentation/blocs/choose_language_cubit/choose_language_cubit.dart';
import 'package:masaj/features/intro/presentation/blocs/guide_page_cubit/guide_page_cubit.dart';
import 'package:masaj/features/medical_form/data/datasource/medical_form_datasource.dart';
import 'package:masaj/features/medical_form/data/repo/medical_form_repo.dart';
import 'package:masaj/features/medical_form/presentation/bloc/medical_form_bloc/medical_form_bloc.dart';
import 'package:masaj/features/members/data/datasource/members_datasource.dart';
import 'package:masaj/features/members/data/repo/members_repo.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';
import 'package:masaj/features/membership/data/datasource/membership_datasource.dart';
import 'package:masaj/features/membership/data/repo/membership_repo.dart';
import 'package:masaj/features/membership/presentaion/bloc/membership_cubit.dart';
import 'package:masaj/features/payment/data/datasource/payment_datasource.dart';
import 'package:masaj/features/payment/data/repo/payment_repo.dart';
import 'package:masaj/features/payment/presentaion/bloc/payment_cubit.dart';
import 'package:masaj/features/providers_tab/data/datasources/providers_tab_remote_data_source.dart';
import 'package:masaj/features/providers_tab/data/repositories/providers_tab_repository.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/home_therapists_cubit/home_therapists_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/providers_tab_cubit/providers_tab_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/therapist_details_cubit/therapist_details_cubit.dart';
import 'package:masaj/features/quiz/application/quiz_page_cubit.dart';
import 'package:masaj/features/quiz/data/repositories/quiz_repo_impl.dart';
import 'package:masaj/features/quiz/domain/repositories/quiz_repo.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';
import 'package:masaj/features/services/application/service_cubit/service_cubit.dart';
import 'package:masaj/features/services/application/service_details_cubit/service_details_cubit.dart';
import 'package:masaj/features/services/data/datasource/service_datasource.dart';
import 'package:masaj/features/services/data/repository/service_repository.dart';
import 'package:masaj/features/splash/data/datasources/splash_local_data_source.dart';
import 'package:masaj/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:masaj/features/splash/presentation/splash_cubit/splash_cubit.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:masaj/features/wallet/data/data_source/wallet_data_source.dart';
import 'package:masaj/features/wallet/data/repos/wallet_repo_impl.dart';
import 'package:masaj/main.dart';

import 'di_wrapper.dart';

void setup() {
  DI.setSingleton<CacheManager>(() => CacheManagerImpl());
  DI.setSingleton<DeviceLocation>(() => DeviceLocationImpl());
  DI.setSingleton<DeviceTypeDataSource>(() => DeviceTypeDataSourceImpl());
  DI.setSingleton<NetworkServiceUtil>(() => NetworkServiceUtilImpl(DI.find()));
  DI.setSingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(DI.find(), DI.find()));
  DI.setSingleton<NetworkService>(() => NetworkServiceImpl(DI.find(), DI.find(), DI.find()));
  DI.setSingleton<QuizRepo>(() => QuizRepoImpl(
        DI.find(),
        DI.find(),
      ));
  DI.setSingleton<AddressRepo>(() => AddressRepo(
        DI.find(),
        DI.find(),
        DI.find(),
        DI.find(),
      ));
  DI.setSingleton<CountriesRepo>(() => CountriesRepoImpl(DI.find()));

  DI.setFactory<EditAddressCubit>(() => EditAddressCubit(DI.find()));
  DI.setFactory<InitiallySelectAreaCubit>(() => InitiallySelectAreaCubit(DI.find()));
  DI.setFactory<MapLocationPickerCubit>(() => MapLocationPickerCubit(DI.find()));
  DI.setFactory<MyAddressesCubit>(() => MyAddressesCubit(DI.find()));
  DI.setFactory<NotInitiallySelectAreaCubit>(() => NotInitiallySelectAreaCubit(DI.find()));
  DI.setFactory<QuizPageCubit>(() => QuizPageCubit(DI.find()));
  DI.setFactory<AddAddressCubit>(() => AddAddressCubit(DI.find()));

  //===================[SPLASH_CUBIT]===================
  DI.setFactory<SplashCubit>(() => SplashCubit(deviceSecurityService: DI.find(), notificationService: DI.find(), splashRepository: DI.find()));

  DI.setSingleton<SplashRepository>(() => SplashRepositoryImpl(DI.find()));

  DI.setSingleton<NotificationsRemoteDataSource>(() => NotificationsRemoteDataSourceImpl(DI.find()));

  DI.setSingleton<NotificationsRepository>(() => NotificationsRepositoryImpl(DI.find()));

  DI.setSingleton<ReviewRemoteDataSource>(() => ReviewRemoteDataSourceImpl(DI.find()));

  DI.setSingleton<ReviewRepository>(() => ReviewRepositoryImpl(DI.find()));

  DI.setSingleton<SplashLocalDataSource>(() => SplashLocalDataSourceImpl(DI.find()));

  //===================[AUTH_CUBIT]===================
  DI.setFactory<AuthCubit>(() => AuthCubit( DI.find(), DI.find() ));

  DI.setSingleton<AuthManager>(() => AuthManagerImpl(
        DI.find(),
        DI.find(),
        DI.find(),
        DI.find(),
        DI.find(label: 'apple'),
        DI.find(label: 'google'),
      ));

  DI.setSingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(DI.find()));

  DI.setSingleton<ServiceRemoteDataSource>(() => ServiceRemoteDataSourceImpl(DI.find()));

  DI.setSingleton<ServiceRepository>(() => ServiceRepositoryImpl(DI.find()));

  DI.setFactory<ServiceCategoryCubit>(() => ServiceCategoryCubit(DI.find()));

  DI.setFactory<ServiceCubit>(() => ServiceCubit(DI.find()));

  DI.setFactory<ServiceDetailsCubit>(() => ServiceDetailsCubit(DI.find()));

  DI.setSingleton<TherapistsDataSource>(() => TherapistsDataSourceImpl(DI.find()));

  DI.setSingleton<TherapistsRepository>(() => TherapistsRepositoryImpl(providers_tabRemoteDataSource: DI.find()));

  //===================[COUNTRY_CUBIT]===================
  DI.setFactory<CountryCubit>(() => CountryCubit(
        DI.find(),
        DI.find(),
      ));

  //===================[GUIDE_PAGE_CUBIT]===================
  DI.setFactory<GuidePageCubit>(() => GuidePageCubit(DI.find()));

  //===================[CHOOSE_LANGUAGE_CUBIT]===================
  DI.setFactory<ChooseLanguageCubit>(() => ChooseLanguageCubit(DI.find()));

  //===================[HOME_CUBIT]===================
  DI.setFactory<HomeCubit>(() => HomeCubit(
        DI.find(),
        DI.find(),
      ));

  DI.setSingleton<HomeRepository>(() => HomeRepositoryImpl(
        homeLocalDatasource: DI.find(),
        homeRemoteDataSource: DI.find(),
      ));

  DI.setSingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(DI.find()));

  DI.setSingleton<HomeLocalDatasource>(() => HomeLocalDatasourceImpl(DI.find()));

  //===================[ABOUT_US_CUBIT]===================
  DI.setFactory<AboutUsCubit>(() => AboutUsCubit(DI.find()));

  DI.setSingleton<AccountRepository>(() => AccountRepositoryImpl(accountRemoteDataSource: DI.find()));

  DI.setSingleton<AccountRemoteDataSource>(() => AccountRemoteDataSourceImpl(DI.find()));

  //===================[TOPICS_CUBIT]===================
  DI.setFactory<TopicsCubit>(() => TopicsCubit(DI.find()));

  //===================[CONTACT_US_CUBIT]===================
  DI.setFactory<ContactUsCubit>(() => ContactUsCubit(DI.find()));

  //===================[MORE_TAB_CUBIT]===================
  DI.setFactory<MoreTabCubit>(() => MoreTabCubit(
        accountRepository: DI.find(),
        launcherService: DI.find(),
        appInfoService: DI.find(),
        showCaseHelper: DI.find(),
      ));

  //===================[FAVORITES_CUBIT]===================

  DI.setFactory<FavoritesCubit>(() => FavoritesCubit(DI.find()));

  DI.setSingleton<FavoritesRepository>(() => FavoritesRepositoryImpl(favoritesRemoteDataSource: DI.find()));

  DI.setSingleton<FavoritesRemoteDataSource>(() => FavoritesRemoteDataSourceImpl(DI.find()));
  //===================[Payment_CUBIT]===================

  DI.setSingleton<PaymentService>(() => PaymentServiceImpl(DI.find(), DI.find()));

  DI.setFactory<PaymentCubit>(() => PaymentCubit(paymentRepository: DI.find(), paymentService: DI.find()));

  DI.setSingleton<PaymentRepository>(() => PaymentRepositoryImp(paymentDataSource: DI.find()));

  DI.setSingleton<PaymentDataSource>(() => PaymentDataSourceImpl(networkService: DI.find()));

  //===================[COUPON_DETAILS_CUBIT]===================

  DI.setFactory<CouponDetailsCubit>(() => CouponDetailsCubit(DI.find()));

  //===================[POINTS_CUBIT]===================

  DI.setFactory<PointsCubit>(() => PointsCubit(DI.find()));

  //===================[MEMBERS_CUBIT]===================

  DI.setFactory<MembersCubit>(() => MembersCubit(membersRepository: DI.find()));

  DI.setSingleton<MembersRepository>(() => MembersRepositoryImp(membersDataSource: DI.find()));

  DI.setSingleton<MembersDataSource>(() => MembersDataSourceImpl(networkService: DI.find()));

  //===================[BOOKING_CUBIT]===================

  DI.setFactory<BookingCubit>(() => BookingCubit(DI.find()));

  DI.setSingleton<BookingRepository>(() => BookingRepositoryImpl(DI.find()));

  DI.setSingleton<BookingRemoteDataSource>(() => BookingRemoteDataSourceImpl(DI.find()));

  //===================[COUPONS_CUBIT]===================

  DI.setFactory<CouponCubit>(() => CouponCubit(DI.find()));

  //===================[WALLET_CUBIT]===================

  DI.setFactory<WalletBloc>(() => WalletBloc(DI.find(), DI.find()));

  DI.setSingleton<WalletRepository>(() => WalletRepositoryImpl(DI.find()));

  DI.setSingleton<WalletDataSource>(() => WalletDataSourceImpl(DI.find()));

  //===================[GIFTS_CUBIT]===================

  DI.setFactory<GiftsCubit>(() => GiftsCubit(giftsRepository: DI.find(), paymentService: DI.find()));

  DI.setSingleton<GiftsRepository>(() => GiftsRepositoryImp(giftsDataSource: DI.find()));

  DI.setSingleton<GiftsDataSource>(() => GiftsDataSourceImpl(networkService: DI.find()));

  //===================[Medical_Form_Bloc]===================

  DI.setFactory<MedicalFormBloc>(() => MedicalFormBloc(DI.find()));

  DI.setSingleton<MedicalFormRepository>(() => MedicalFormRepositoryImp(DI.find()));

  DI.setSingleton<MedicalFormDataSource>(() => MedicalFormDataSourceImpl(networkService: DI.find()));

  //===================[Membership_Bloc]===================

  DI.setFactory<MembershipCubit>(() => MembershipCubit(membershipRepository: DI.find(), paymentService: DI.find()));

  DI.setSingleton<MembershipRepository>(() => MembershipRepositoryImp(membershipDataSource: DI.find()));

  DI.setSingleton<MembershipDataSource>(() => MembershipDataSourceImpl(networkService: DI.find()));

  //===================[NOTIFICATIONS_CUBIT]===================
  DI.setFactory<NotificationsCubit>(() => NotificationsCubit(DI.find(), DI.find()));

  //===================[CORE_DATA]===================

  DI.setSingleton<DeviceSecurityService>(() => DeviceSecurityServiceImpl());

  DI.setSingleton<AppInfoService>(() => AppInfoServiceImpl());

  DI.setSingleton<NotificationService>(() => NotificationService(DI.find()));

  DI.setSingleton<ExternalLoginDataSource>(() => AppleExternalLoginDataSourceImpl(), label: 'apple');

  DI.setSingleton<ExternalLoginDataSource>(() => GoogleExternalLoginDataSourceImpl(), label: 'google');

  DI.setSingleton<LauncherService>(() => LauncherServiceImpl());

  DI.setSingleton<ShareService>(() => ShareServiceImpl());

  DI.setSingleton<ShowCaseHelper>(() => ShowCaseHelper(DI.find()));

  DI.setSingleton<AddToAppleWalletService>(() => AddToAppleWalletServiceImpl());

  DI.setFactory<ProvidersTabCubit>(() => ProvidersTabCubit(
        providersTabRepository: DI.find(),
      ));

  DI.setFactory<BookingsTabCubit>(() => BookingsTabCubit(
        bookingsTabRepository: DI.find(),
      ));

  DI.setFactory<BookingDetailsCubit>(() => BookingDetailsCubit(DI.find()));

  DI.setFactory<AvialbleTherapistCubit>(() => AvialbleTherapistCubit(
        providersTabRepository: DI.find(),
      ));

  DI.setFactory<HomeTherapistsCubit>(() => HomeTherapistsCubit(DI.find()));

  DI.setFactory<TherapistDetailsCubit>(() => TherapistDetailsCubit(
        DI.find(),
      ));

  DI.setFactory<HomeSearchCubit>(() => HomeSearchCubit(
        homeRepository: DI.find(),
      ));

  DI.setFactory<HomePageCubit>(() => HomePageCubit(
        DI.find(),
        DI.find(),
        DI.find(),
      ));
  //===================[REVIEW_TIPS_CUBIT]===================
  DI.setFactory<ReviewTipsCubit>(() => ReviewTipsCubit(
        DI.find(),
        DI.find(),
      ));

  //=========================[Logger]============================

  if (BUILD_TYPE == BuildType.debug) {
    DI.setSingleton<AbsLogger>(() => DebugLogger()
      ..setLogLevel(LogLevel.debug)
      ..enableLongLogs = true
      ..splitLog = false
      ..normalPrint = false
      ..enableAnsiColors(false));
  } else if (BUILD_TYPE == BuildType.test) {
    DI.setSingleton<AbsLogger>(() => MemoryLogger()
      ..setLogLevel(LogLevel.debug)
      ..maxLength = 10);
  } else {
    //release
    DI.setSingleton<AbsLogger>(() => FakeLogger());
  }
}
