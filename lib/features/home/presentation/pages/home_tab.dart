import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/size/size_utils.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/book_service/data/models/booking_model/session_model.dart';
import 'package:masaj/features/home/data/models/banner.dart';
import 'package:masaj/features/home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/home_page_cubit/home_page_cubit.dart';
import 'package:masaj/features/home/presentation/widget/index.dart';
import 'package:masaj/features/services/data/models/service_model.dart';
import 'package:masaj/features/services/data/models/service_offer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    final cubit = context.read<AuthCubit>();
    final isGuest = cubit.state.isGuest;

    context.read<HomePageCubit>().init(isGuest: isGuest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        final cubit = context.read<HomePageCubit>();
        return RefreshIndicator(
          onRefresh: cubit.refresh,
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
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),

                  // horizontal list view of categories
                  const CategoriesList(
                    isSliver: true,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20.h,
                    ),
                  ),
                  if (state.isLoaded) ...homeSection(state),
                  if (state.isLoading) ...[
                    const SliverToBoxAdapter(
                      child: CustomLoading(
                        loadingStyle: LoadingStyle.ShimmerList,
                      ),
                    ),
                  ],

                  // therapists
                  const Therapists(),

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
  }

  List<Widget> buildRepeatedSessions(List<SessionModel> repeatedSessions) => [
        RepeatedSessions(
          repeatedSessions: repeatedSessions,
        ),
        SliverToBoxAdapter(
            child: SizedBox(
          height: 30.h,
        ))
      ];

  List<Widget> buildAdsSection(List<BannerModel> banners) => [
        Ads(
          banners: banners,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20.h,
          ),
        ),
      ];

  List<Widget> buildOffersSection(List<ServiceOffer> offers) => [
        OffersSection(
          offers: offers,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20.h,
          ),
        ),
      ];
  List<Widget> buildRecommendedSection(
          List<ServiceModel> recommendedServices) =>
      [
        Recommended(
          recommendedServices: recommendedServices,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20.h,
          ),
        ),
      ];

  List<Widget> homeSection(HomePageState state) => [
        // title : Repeat session with list view of sessions
        if (state.repeatedSessions != null &&
            state.repeatedSessions?.isNotEmpty == true)
          ...buildRepeatedSessions(state.repeatedSessions ?? []),

        // image slider
        if (state.banners != null && state.banners?.isNotEmpty == true)
          ...buildAdsSection(state.banners ?? []),
        // offers
        if (state.offers != null && state.offers?.isNotEmpty == true)
          ...buildOffersSection(state.offers ?? []),
        // recommended
        if (state.recommendedServices != null &&
            state.recommendedServices?.isNotEmpty == true)
          ...buildRecommendedSection(state.recommendedServices ?? []),
      ];

  Widget _buildBody(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) return const CustomLoading();
        if (state.homeData == null) {
          return EmptyPageMessage(
            message: 'home_page_is_empty',
            heightRatio: .9,
            onRefresh: cubit.refresh,
          );
        }

        final homeData = state.homeData;

        if (homeData != null) {
          return EmptyPageMessage(
            message: 'home_page_is_empty',
            heightRatio: .9,
            onRefresh: cubit.refresh,
          );
        }

        return RefreshIndicator(
          onRefresh: cubit.refresh,
          color: AppColors.ACCENT_COLOR,
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              Text('home tab'),
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
