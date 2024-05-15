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
        create: (context) => Injector().membershipCubit..getSubscriptionPlans(),
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
    return Padding(
        padding: EdgeInsets.all(24.w), child: _buildMembershipList());
  }

  Widget _buildMembershipList() {
    return BlocBuilder<MembershipCubit, MembershipState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CustomLoading();
        }
        final plans = state.plans;

        if ((plans == null)) {
          return const EmptyPageMessage(
            heightRatio: 0.6,
          );
        }
        return _buildPlanItem(plans);
      },
    );
  }

  Container _buildPlanItem(Plan? plan) {
    return Container(
      decoration: BoxDecoration(
          gradient: AppColors.GRADIENT_COLOR,
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(24.w),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubtitleText.large(
              text: plan?.nameEn ?? '',
              color: AppColors.ExtraLight,
              isBold: true,
            ),
            SizedBox(height: 12.h),
            SubtitleText.medium(
              text: 'lbl_kwd'.tr(args: [plan!.price.toString()]),
              isBold: true,
              color: AppColors.ExtraLight,
            ),
            SubtitleText(
              text: '/month',
              color: AppColors.ExtraLight,
            ),
            SizedBox(height: 12.h),
            SubtitleText(
              text: plan.descriptionEn ?? '',
              color: AppColors.ExtraLight,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 300,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    _buildBenefitItem(plan.benefits?[index].benefitEn ?? ''),
                itemCount: plan.benefits?.length,
              ),
            ),
            DefaultButton(
              onPressed: () {},
              textColor: AppColors.PRIMARY_COLOR,
              color: AppColors.ExtraLight,
              isExpanded: true,
              label: 'upgrade',
            )
          ]),
    );
  }

  Row _buildBenefitItem(String title) {
    return Row(
      children: [
        Icon(
          Icons.check,
          color: AppColors.ExtraLight,
        ),
        SizedBox(width: 20.w),
        SubtitleText(
          text: title,
          color: AppColors.ExtraLight,
        )
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
