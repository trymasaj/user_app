import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/size/size_utils.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/features/home/presentation/bloc/home_cubit/home_cubit.dart';

import 'package:masaj/features/home/presentation/widget/index.dart';
import 'package:masaj/features/services/application/service_catgory_cubit/service_category_cubit.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return CustomAppPage(
      safeBottom: false,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
            const CategoriesList(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            // title : Repeate session with list view of sessions
            const RepeatedSessions(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 30.h,
              ),
            ),
            // image slider
            const Ads(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            // offers
            const OffersSection(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            // recommended
            const Recommended(),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20.h,
              ),
            ),
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
    );
  }

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
