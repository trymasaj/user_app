import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/events.dart';
// import 'package:masaj/core/data/services/adjsut.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/size/size_utils.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/book_service/data/models/booking_model/session_model.dart';
import 'package:masaj/features/home/data/models/banner.dart';
import 'package:masaj/features/home/data/models/home_section.dart';
import 'package:masaj/features/home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/home_page_cubit/home_page_cubit.dart';
import 'package:masaj/features/home/presentation/widget/index.dart';
import 'package:masaj/features/providers_tab/presentation/cubits/home_therapists_cubit/home_therapists_cubit.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_offer.dart';
import 'package:masaj/main.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late ServiceCategoryCubit serviceCategoryCubit;

  @override
  void initState() {
    final cubit = context.read<AuthCubit>();
    final isGuest = cubit.state.isGuest;
    serviceCategoryCubit = context.read<ServiceCategoryCubit>();
    serviceCategoryCubit.getServiceCategories();
    eventBus.fire(RefreshHomeTabTherapistsEB());
    context.read<HomePageCubit>().init(isGuest: isGuest);
    super.initState();
  }

  List<Widget> sortSection(
      {required List<Widget> children,
      required HomeState homeState,
      required HomePageState homePageState}) {
    final sections = homeState.homeSections ?? [];
    sections.sort((a, b) => (int.tryParse(a.sectionKey ?? '') ?? 0));

    final selectedSections = children
        .where((element) =>
            sections.map((e) => Key(e.sectionKey ?? '')).contains(element.key))
        .toList();

    return selectedSections;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        return BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            final cubit = context.read<HomePageCubit>();
            return RefreshIndicator(
              onRefresh: () async {
                serviceCategoryCubit.getServiceCategories();
                await context.read<HomeCubit>().refresh();
                await cubit.refresh();
              },
              child: CustomAppPage(
                safeBottom: false,
                child: Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.startFloat,
                  body: CustomScrollView(
                    slivers: [
                      const FixedAppBar(),

                      SliverToBoxAdapter(
                          child: SizedBox(
                        height: 20.h,
                      )),

                      // search bar
                      const SearchField(),
                      SliverToBoxAdapter(
                          key: const Key(HomeSectionModel.homeCategoryKey),
                          child: buildCategoryScetion()),
                      if (homeState.isLoading)
                        const SliverToBoxAdapter(
                          child: CustomLoading(
                            loadingStyle: LoadingStyle.ShimmerList,
                          ),
                        )
                      else
                        ...sortSection(
                            homeState: homeState,
                            homePageState: state,
                            children: [

                              // horizontal list view of categories

                              // if (state.isLoaded) ...homeSection(state),
                              SliverToBoxAdapter(
                                  key:
                                      const Key(HomeSectionModel.homeRepeatKey),
                                  child: buildRepeatedSessions(state)),

                              SliverToBoxAdapter(
                                  key: const Key(HomeSectionModel.homeBanners),
                                  child: buildAdsSection(state)),
                              // offers
                              SliverToBoxAdapter(
                                  key:
                                      const Key(HomeSectionModel.homeOffetsKey),
                                  child: buildOffersSection(state)),
                              // recommended
                              SliverToBoxAdapter(
                                  key: const Key(
                                      HomeSectionModel.homeRecommendedKey),
                                  child: buildRecommendedSection(state)),

                              // therapists
                              if (!context.read<AuthCubit>().state.isGuest) const Therapists(
                                key: const Key(HomeSectionModel.homeTherapists),
                              ),
                            ]),

                      // space of bottom bar height
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: kBottomNavigationBarHeight + 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildCategoryScetion() => Column(
        children: [
          CategoriesList(
            serviceCategoryCubit: serviceCategoryCubit,
            isSliver: false,
            inHomePage: true,
          ),
          SizedBox(
            height: 20.h,
          )
        ],
      );
  Widget buildRepeatedSessions(HomePageState state) {
    if (state.repeatedSessions != null &&
        state.repeatedSessions?.isNotEmpty == true &&
        !state.isLoading) {
      final repeatedSessions = state.repeatedSessions ?? [];
      return Column(
        children: [
          RepeatedSessions(
            repeatedSessions: repeatedSessions,
          ),
          SizedBox(
            height: 30.h,
          )
        ],
      );
    } else if (state.isLoading) {
      return CustomLoading(
        loadingStyle: LoadingStyle.ShimmerList,
      );
    }
    return Container();
  }

  Widget buildAdsSection(HomePageState state) {
    if (state.banners != null &&
        state.banners?.isNotEmpty == true &&
        !state.isLoading) {
      final banners = state.banners ?? [];
      return Column(
        children: [
          Ads(
            banners: banners,
          ),
          SizedBox(
            height: 30.h,
          )
        ],
      );
    } else if (state.isLoading) {
      return CustomLoading(
        loadingStyle: LoadingStyle.ShimmerList,
      );
    }
    return Container();
  }
  // (
  //   List<BannerModel> banners) => [
  //       Ads(
  //         banners: banners,
  //       ),
  //       SliverToBoxAdapter(
  //         child: SizedBox(
  //           height: 20.h,
  //         ),
  //       ),
  //     ];

  Widget buildOffersSection(HomePageState state) {
    if (state.offers != null &&
        state.offers?.isNotEmpty == true &&
        !state.isLoading) {
      final offers = state.offers ?? [];
      return Column(
        children: [
          OffersSection(
            offers: offers,
          ),
          SizedBox(
            height: 30.h,
          )
        ],
      );
    } else if (state.isLoading) {
      return CustomLoading(
        loadingStyle: LoadingStyle.ShimmerList,
      );
    }
    return Container();
  }

  // (List<ServiceOffer> offers) => [
  //       OffersSection(
  //         offers: offers,
  //       ),
  //       SliverToBoxAdapter(
  //         child: SizedBox(
  //           height: 20.h,
  //         ),
  //       ),
  //     ];
  Widget buildRecommendedSection(HomePageState state) {
    if (state.recommendedServices != null &&
        state.recommendedServices?.isNotEmpty == true &&
        !state.isLoading) {
      final recommendedServices = state.recommendedServices ?? [];
      return Column(
        children: [
          Recommended(
            recommendedServices: recommendedServices,
          ),
          SizedBox(
            height: 30.h,
          )
        ],
      );
    } else if (state.isLoading) {
      return CustomLoading(
        loadingStyle: LoadingStyle.ShimmerList,
      );
    }
    return Container();
  }
  // (
  //         List<ServiceModel> recommendedServices) =>
  //     [
  //       Recommended(
  //         recommendedServices: recommendedServices,
  //       ),
  //       SliverToBoxAdapter(
  //         child: SizedBox(
  //           height: 20.h,
  //         ),
  //       ),
  //     ];

  List<Widget> homeSection(HomePageState state) => [
        // title : Repeat session with list view of sessions
        // if (state.repeatedSessions != null &&
        //     state.repeatedSessions?.isNotEmpty == true)
        //   ...buildRepeatedSessions(state.repeatedSessions ?? []),

        // // image slider
        // if (state.banners != null && state.banners?.isNotEmpty == true)
        //   ...buildAdsSection(state.banners ?? []),
        // // offers
        // if (state.offers != null && state.offers?.isNotEmpty == true)
        //   ...buildOffersSection(state.offers ?? []),
        // // recommended
        // if (state.recommendedServices != null &&
        //     state.recommendedServices?.isNotEmpty == true)
        //   ...buildRecommendedSection(state.recommendedServices ?? []),
      ];

  Widget _buildBody(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) return const CustomLoading();
        if (state.homeData == null) {
          return EmptyPageMessage(
            message: AppText.home_page_is_empty,
            heightRatio: .9,
            onRefresh: cubit.refresh,
          );
        }

        final homeData = state.homeData;

        if (homeData != null) {
          return EmptyPageMessage(
            message: AppText.home_page_is_empty,
            heightRatio: .9,
            onRefresh: cubit.refresh,
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.refresh,
          color: AppColors.ACCENT_COLOR,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Text(AppText.home),
            ],
          ),
        );
      },
    );
  }
}

// create ImageSlider widget

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.FONT_COLOR),
    );
  }
}
