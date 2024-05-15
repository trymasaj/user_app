import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_loading.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';

import 'package:masaj/core/presentation/widgets/stateless/empty_page_message.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';


import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/members/data/model/member_model.dart';
import 'package:masaj/features/members/presentaion/bloc/members_cubit.dart';
import 'package:masaj/features/membership/data/model/membership_model.dart';
import 'package:masaj/features/membership/presentaion/bloc/membership_cubit.dart';

class MembershipPlansScreen extends StatefulWidget {
  const MembershipPlansScreen({
    super.key,
  });

  @override
  State<MembershipPlansScreen> createState() => _MembershipPlansScreenState();
}

class _MembershipPlansScreenState extends State<MembershipPlansScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Injector().membersCubit..getMembers(),
        child: BlocBuilder<MembershipCubit, MembershipState>(
          builder: (context, state) {
            return CustomAppPage(
              child: Scaffold(
                  appBar: CustomAppBar(
                    title: 'lbl_membership'.tr(),
                  ),
                  body: _buildBody(context)),
            );
          },
        ));
  }

  Padding _buildBody(BuildContext context) {
    final cubit = context.read<MembershipCubit>();
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: _buildMembershipList());
  }

  Widget _buildMembershipList() {
    return Builder(builder: (context) {
      final cubit = context.read<MembershipCubit>();

      return Expanded(
        flex: 10,
        child: BlocBuilder<MembershipCubit, MembershipState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CustomLoading();
            }
            final plans = state.plans ?? [];

            if ((plans == [] || plans.isEmpty)) {
              return const EmptyPageMessage(
                heightRatio: 0.6,
              );
            }
            return _buildMembersList(cubit);
          },
        ),
      );
    });
  }

  Widget _buildMembersList(MembershipCubit cubit) {
    return ListView.builder(
      itemCount: cubit.state.plans?.length,
      itemBuilder: (context, index) => _buildMemberItem(cubit, index),
    );
  }

  Widget _buildMemberItem(MembershipCubit cubit, int index) {
    final plans = cubit.state.plans;
    return BlocBuilder<MembersCubit, MembersState>(
      builder: (context, state) {
        return _buildPlanItem(plans?[index]);
      },
    );
  }

  Container _buildPlanItem(Plan? plan) {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.GRADIENT_COLOR),
      child: Column(children: [
        SubtitleText(text: plan?.nameEn ?? ''),
        SubtitleText(text: 'lbl_kwd'.tr(args: [plan!.price.toString()])),
        SubtitleText(text: plan.duration ?? ''),
        SubtitleText(text: plan.descriptionEn ?? ''),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              _buildBenefitItem(plan.benefits?[index].benefitEn ?? ''),
          itemCount: plan.benefits?.length,
        ),
        DefaultButton(
          onPressed: () {},
          isExpanded: true,
          label: 'upgrade',
        )
      ]),
    );
  }

  Row _buildBenefitItem(String title) {
    return Row(
      children: [
        Icon(Icons.check),
        SizedBox(width: 20.w),
        SubtitleText(text: title)
      ],
    );
  }

  void _validateMembers(bool? value, MemberModel member, BuildContext context) {
    final cubit = context.read<MembersCubit>();
    final selectedMembers = cubit.state.selectedMembers ?? [];

    if (selectedMembers.isNotEmpty && !(member.isSelected ?? false)) {
      if (selectedMembers.length >= 2) {
        return showSnackBar(context, message: 'members_number_limit');
      }
      if (selectedMembers[0].gender != member.gender) {
        return showSnackBar(context, message: 'members_number_gender_limit');
      }
    }
    cubit.updateSelectedMembers(value, member);
  }
}
