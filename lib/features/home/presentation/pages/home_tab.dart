import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateless/custom_loading.dart';
import '../../../../shared_widgets/stateless/empty_page_message.dart';
import '../bloc/home_cubit/home_cubit.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return CustomAppPage(
      safeBottom: false,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) return const CustomLoading();
        if (state.homeData == null)
          return EmptyPageMessage(
            message: 'home_page_is_empty',
            heightRatio: .9,
            onRefresh: cubit.refresh,
          );

        final homeData = state.homeData;

        if (homeData != null)
          return EmptyPageMessage(
            message: 'home_page_is_empty',
            heightRatio: .9,
            onRefresh: cubit.refresh,
          );

        return RefreshIndicator(
          onRefresh: cubit.refresh,
          color: AppColors.ACCENT_COLOR,
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              Text("home tab"),
            ],
          ),
        );
      },
    );
  }
}
