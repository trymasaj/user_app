import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
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
import 'package:masaj/features/membership/presentaion/pages/membership_details_screen.dart';

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
        create: (context) => Injector().membershipCubit..init(),
        child: BlocBuilder<MembershipCubit, MembershipState>(
          builder: (context, state) {
            return CustomAppPage(
              child: Scaffold(
                appBar: CustomAppBar(
                  title: 'lbl_membership_plan'.tr(),
                ),
                body: _buildBody(context),
              ),
            );
          },
        ));
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(24.w), child: _buildMembershipList());
  }

  Widget _buildMembershipList() {
    return BlocConsumer<MembershipCubit, MembershipState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CustomLoading();
        }
        if (state.selectedSubscription?.id != 0) {
          final SubscriptionModel? selectedSubscription =
              state.selectedSubscription;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.ACCENT_COLOR)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SubtitleText.medium(text: 'lbl_current_plan'),
                    SubtitleText.large(
                      text: selectedSubscription?.plan?.nameEn ?? '',
                      isBold: true,
                    ),
                    Row(
                      children: [
                        SubtitleText.small(
                            text: 'lbl_kwd'.tr(args: [
                          selectedSubscription?.plan?.price.toString() ?? ''
                        ])),
                        const Spacer(),
                        SubtitleText.small(
                            text: selectedSubscription?.endsAt ?? '')
                      ],
                    ),
                    const SubtitleText.small(text: '/month'),
                    DefaultButton(
                      label: 'lbl_cancel',
                      onPressed: () {
                        showAdaptiveDialog(
                            useRootNavigator: true,
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return BlocProvider(
                                create: (context) => Injector().membershipCubit,
                                child: BlocBuilder<MembershipCubit,
                                    MembershipState>(
                                  builder: (context, state) {
                                    return AlertDialog.adaptive(
                                      iconPadding: const EdgeInsets.all(20),
                                      alignment: Alignment.center,
                                      title: const SubtitleText.large(
                                          isBold: true,
                                          text: 'msg_cancel_subscription'),
                                      content: const SubtitleText.medium(
                                          text: 'msg_are_you_sure_you2'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            NavigatorHelper.of(context).pop();
                                          },
                                          child: const SubtitleText(
                                              text: 'lbl_cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await context
                                                .read<MembershipCubit>()
                                                .cancelSubscriptionPlans();
                                            NavigatorHelper.of(context).pop();
                                            NavigatorHelper.of(context).pop();
                                          },
                                          child: const Center(
                                            child: SubtitleText.small(
                                              text: 'msg_cancel_subscription',
                                              color: AppColors.ERROR_COLOR,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              );
                            });
                      },
                      color: AppColors.ExtraLight,
                      isExpanded: true,
                      textColor: AppColors.ACCENT_COLOR,
                    )
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Flexible(
                  child: _buildPlanItem(context, selectedSubscription?.plan,
                      showUpgrade: false))
            ],
          );
        }
        final plans = state.plans;

        if ((plans == null)) {
          return const EmptyPageMessage(
            heightRatio: 0.6,
          );
        }
        return _buildPlanItem(context, plans);
      },
      listener: (BuildContext context, MembershipState state) {
        if (state.isError) {
          showSnackBar(context, message: state.errorMessage);
        }
        if (state.isDeleted) {
          showSnackBar(context, message: 'success_cancel');
        }
      },
    );
  }

  Container _buildPlanItem(BuildContext mainContext, Plan? plan,
      {bool showUpgrade = true}) {
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
              text: plan?.name ?? '',
              color: AppColors.ExtraLight,
              isBold: true,
            ),
            SizedBox(height: 12.h),
            SubtitleText.medium(
              text: 'lbl_kwd'.tr(args: [plan!.price.toString()]),
              isBold: true,
              color: AppColors.ExtraLight,
            ),
            const SubtitleText(
              text: 'lbl_month',
              color: AppColors.ExtraLight,
            ),
            SizedBox(height: 12.h),
            SubtitleText(
              text: plan.description ?? '',
              color: AppColors.ExtraLight,
            ),
            SizedBox(height: 24.h),
            Flexible(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    _buildBenefitItem(plan.benefits?[index].benefitEn ?? ''),
                itemCount: plan.benefits?.length ?? 0,
              ),
            ),
            if (showUpgrade)
              DefaultButton(
                onPressed: () {
                  NavigatorHelper.of(context).push(MaterialPageRoute(
                      builder: (context) => MembershipCheckoutScreen(
                            membershipCubit:
                                mainContext.read<MembershipCubit>(),
                          )));
                },
                textColor: AppColors.PRIMARY_COLOR,
                color: AppColors.ExtraLight,
                isExpanded: true,
                label: 'lbl_upgrade',
              )
          ]),
    );
  }

  Row _buildBenefitItem(String title) {
    return Row(
      children: [
        const Icon(
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
}
