import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_cached_network_image.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_rating_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/book_service/presentation/blocs/available_therapist_cubit/available_therapist_cubit.dart';
import 'package:masaj/features/book_service/presentation/screens/book_servcie_screen.dart';
import 'package:masaj/features/home/presentation/widget/category_list.dart';
import 'package:masaj/features/providers_tab/data/models/avilable_therapist_model.dart';
import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/home_therapists_cubit/home_therapists_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/providers_tab_cubit/providers_tab_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/therapist_details_cubit/therapist_details_cubit.dart';
import 'package:masaj/features/providers_tab/presentation/pages/book_with_provider_sreen.dart';
import 'package:masaj/features/providers_tab/presentation/widgets/fav_icon_widget.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';

class ProviderDetailsScreenNavArguements {
  final Therapist therapist;
  ProvidersTabCubit? providersTabCubit;
  HomeTherapistsCubit? homeTherapistsCubit;
  AvialbleTherapistCubit? avialbleTherapistCubit;
  final bool isFromSelectProvidersScreen;
  ProviderDetailsScreenNavArguements(
      {required this.therapist,
      this.providersTabCubit,
      this.avialbleTherapistCubit,
      this.isFromSelectProvidersScreen = false,
      this.homeTherapistsCubit});
}

class ProviderDetailsScreen extends StatefulWidget {
  static const routeName = '/ProviderDetailsScreen';

  const ProviderDetailsScreen({
    super.key,
    required this.therapist,
  });
  final Therapist therapist;

  // builder
  static MaterialPageRoute router(
      {required Therapist therapist,
      ProvidersTabCubit? providersTabCubit,
      HomeTherapistsCubit? homeTherapistsCubit,
      AvialbleTherapistCubit? avialbleTherapistCubit}) {
    print('router');
    print(avialbleTherapistCubit);
    return MaterialPageRoute(
        builder: (context) => builder(
            therapist: therapist,
            providersTabCubit: providersTabCubit,
            homeTherapistsCubit: homeTherapistsCubit,
            avialbleTherapistCubit: avialbleTherapistCubit));
  }

  static Widget builder(
      {required Therapist therapist,
      ProvidersTabCubit? providersTabCubit,
      HomeTherapistsCubit? homeTherapistsCubit,
      AvialbleTherapistCubit? avialbleTherapistCubit}) {
    return MultiBlocProvider(providers: [
      if (providersTabCubit != null)
        BlocProvider.value(
          value: providersTabCubit,
        ),
      if (avialbleTherapistCubit != null)
        BlocProvider.value(
          value: avialbleTherapistCubit,
        ),
      if (homeTherapistsCubit != null)
        BlocProvider.value(
          value: homeTherapistsCubit,
        ),
      BlocProvider(
        create: (context) => Injector().therapistDetailsCubit
          ..setTherapist(therapist)
          ..getTherapistDetails(therapist.therapistId ?? 0),
        child: ProviderDetailsScreen(
          therapist: therapist,
        ),
      )
    ], child: ProviderDetailsScreen(therapist: therapist));
  }

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen> {
  late ScrollController _scrollController;
  bool get fromBookServiceScreen =>
      context.read<AvialbleTherapistCubit?>() != null;

  Widget _buildHeader(
    final Therapist therapist,
  ) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            _buildImage(
              therapist,
            ),
            SizedBox(
              height: 4.h,
            ),
            CustomText(
              text: therapist.fullName ?? '',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            CustomText(
              text: therapist.title ?? '',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.FONT_LIGHT.withOpacity(.7),
            ),
            // row of countery flag and country name
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CountryFlag.fromCountryCode(therapist.country?.isoCode ?? 'KW',
                    height: 15, width: 15),
                SizedBox(
                  width: 5.w,
                ),
                const CustomText(
                  text: 'Kuwaiti',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.PlaceholderColor,
                ),
              ],
            ),
            // share button #F6F6F6
            SizedBox(
              height: 6.h,
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildImage(
    final Therapist therapist,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80.h,
          height: 80.h,
          margin: EdgeInsets.only(top: 24.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: CustomCachedNetworkImageProvider(
                  therapist.profileImage ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // review icon
        Positioned(
          bottom: -(19.h / 2),
          left: 40.h - 19,
          width: 38.w,
          height: 19.h,
          child: Container(
            // alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: const Color(0xffECECEC),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/start.svg',
                  width: 10.w,
                  height: 10.h,
                ),
                const SizedBox(
                  width: 2,
                ),
                CustomText(
                  text: (therapist.rank ?? 0).toString(),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAbout(
    String about,
  ) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            const Row(
              children: [
                CustomText(
                  text: 'lbl_about',
                  fontFamily: 'DM Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff1D212C),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            CustomText(
              text: about,
              fontFamily: 'DM Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.FONT_LIGHT.withOpacity(.7),
            ),
          ],
        ),
      ),
    );
  }

  late ServiceCategoryCubit serviceCategoryCubit;
  @override
  void initState() {
    serviceCategoryCubit = Injector().serviceCategoryCubit;
    serviceCategoryCubit.getServiceCategories();
    _scrollController = ScrollController();
    super.initState();
  }

  Widget _buildServiceCategories() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            const Row(
              children: [
                CustomText(
                  text: 'lbl_services',
                  fontFamily: 'DM Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff1D212C),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            CategoriesList(
              serviceCategoryCubit: serviceCategoryCubit,
              onPressed: (category) {
                if (fromBookServiceScreen) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => Injector().serviceCubit,
                              child: BookWithTherapistScreen(
                                  arguments: BookWithTherapistScreenArguments(
                                therapist: widget.therapist,
                                selectedServiceCategory: category,
                                allServiceCategories: serviceCategoryCubit
                                    .state.serviceCategories,
                              )),
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsTitle(
    int reviewsCount,
  ) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                      text: '${'reviews'.tr()} ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1D212C),
                      ),
                      children: [
                        TextSpan(
                          text: '(${reviewsCount})',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.FONT_LIGHT.withOpacity(.7),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            // separated list of reviews
          ],
        ),
      ),
    );
  }

  Widget _buildReviews(
    List<Review> reviews,
  ) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(bottom: 124.h),
      sliver: SliverList.separated(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      // #1D212C
                      text: reviews[index].customerName ?? '',
                      color: Color(0xff1D212C),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),

                  // 20/01/2022
                  CustomText(
                      // #1D212C
                      text: reviews[index].reviewDate?.toIso8601String() ?? '',
                      color: AppColors.PlaceholderColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ],
              ),
              Row(
                children: [
                  CustomRatingBar(
                    itemCount: 5,
                    itemSize: 14,
                  ),
                ],
              ),
              CustomText(
                text: reviews[index].improveServicesHint ?? '',
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.FONT_LIGHT.withOpacity(.7),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 14.h, top: 14.h),
            color: const Color(0xff1D212C).withOpacity(.5),
            height: .5.h,
          );
        },
        itemCount: reviews.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocBuilder<TherapistDetailsCubit, TherapistDetailsState>(
        builder: (context, state) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              margin: EdgeInsets.only(bottom: 24.h),
              width: double.infinity,
              height: 60,
              color: Colors.white,
              child: DefaultButton(
                // label: 'Book with ${state.therapist?.fullName ?? ''}',
                label: 'book_with'.tr(args: [state.therapist?.fullName ?? '']),
                onPressed: () {
                  final isGuest = context.read<AuthCubit>().state.isGuest;
                  if (!isGuest) {
                    if (!fromBookServiceScreen &&
                        serviceCategoryCubit
                                .state.serviceCategories.firstOrNull !=
                            null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) =>
                                        Injector().serviceCubit,
                                    child: BookWithTherapistScreen(
                                        arguments:
                                            BookWithTherapistScreenArguments(
                                      therapist: widget.therapist,
                                      selectedServiceCategory:
                                          serviceCategoryCubit
                                              .state.serviceCategories.first,
                                      allServiceCategories: serviceCategoryCubit
                                          .state.serviceCategories,
                                    )),
                                  )));
                    } else {
                      Navigator.of(context).popUntil((route) {
                        return route.settings.name ==
                            BookServiceScreen.routeName;
                      });
                      context.read<AvialbleTherapistCubit?>()?.selectTherapist(
                          AvailableTherapistModel(
                              therapist: state.therapist,
                              userTriedBefore: null,
                              availableTimeSlots: null));
                    }
                  } else {
                    showGuestSnackBar(context);
                  }
                },
              ));
        },
      ),
      appBar: CustomAppBar(
        elevation: 0,
        title: '',
        actions: [
          BlocConsumer<TherapistDetailsCubit, TherapistDetailsState>(
            listener: (context, state) {
              if (state.isError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.errorMessage ?? ''),
                ));
              }
              if (state.isLoaded && state.therapist != null) {
                context.read<ProvidersTabCubit?>()?.updateTherapist(
                      state.therapist!,
                    );
                print(
                    'updateTherapist in ${context.read<HomeTherapistsCubit?>()}');
                context.read<HomeTherapistsCubit?>()?.updateTherapist(
                      state.therapist!,
                    );
              }
            },
            listenWhen: (previous, current) =>
                previous.isError != current.isError
                    ? true
                    : previous.therapist?.isFavourite !=
                        current.therapist?.isFavourite,
            builder: (context, state) {
              return FavIconWidget(
                onTap: () {
                  context.read<TherapistDetailsCubit>().toggleFav();
                },
                isFav: state.therapist == null
                    ? false
                    : state.therapist!.isFavourite ?? false,
              );
            },
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: BlocBuilder<TherapistDetailsCubit, TherapistDetailsState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildHeader(
                state.therapist ?? widget.therapist,
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 8.h,
                ),
              ),
              _buildAbout(
                state.therapist?.about ?? '',
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 32.h,
                ),
              ),
              _buildServiceCategories(),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 32.h,
                ),
              ),
              _buildReviewsTitle(
                state.therapist?.reviews?.length ?? 0,
              ),
              _buildReviews(state.therapist?.reviews ?? [])
            ],
          );
        },
      ),
    );
  }
}
