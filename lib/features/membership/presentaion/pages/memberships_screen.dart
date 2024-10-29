import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
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
        create: (context) => DI.find<MembershipCubit>()..init(),
        child: BlocBuilder<MembershipCubit, MembershipState>(
          builder: (context, state) {
            return CustomAppPage(
              child: Scaffold(
                appBar: CustomAppBar(
                  title: AppText.lbl_membership_plan,
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
                    SubtitleText.medium(text: AppText.lbl_current_plan),
                    SubtitleText.large(
                      text: selectedSubscription?.plan?.nameEn ?? '',
                      isBold: true,
                    ),
                    Row(
                      children: [
                        SubtitleText.small(
                            text: AppText.lbl_kwd(args: [
                          selectedSubscription?.plan?.price.toString() ?? ''
                        ])),
                        const Spacer(),
                        SubtitleText.small(
                            text: selectedSubscription?.endsAt ?? '')
                      ],
                    ),
                    const SubtitleText.small(text: '/month'),
                    DefaultButton(
                      label: AppText.lbl_cancel,
                      onPressed: () {
                        showAdaptiveDialog(
                            useRootNavigator: true,
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return BlocProvider(
                                create: (context) => DI.find<MembershipCubit>(),
                                child: BlocBuilder<MembershipCubit,
                                    MembershipState>(
                                  builder: (context, state) {
                                    return AlertDialog.adaptive(
                                      iconPadding: const EdgeInsets.all(20),
                                      alignment: Alignment.center,
                                      title: SubtitleText.large(
                                          isBold: true,
                                          text: AppText.msg_cancel_subscription),
                                      content: SubtitleText.medium(
                                          text: AppText.msg_are_you_sure_you2),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            NavigatorHelper.of(context).pop();
                                          },
                                          child: SubtitleText(
                                              text: AppText.lbl_cancel),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await context
                                                .read<MembershipCubit>()
                                                .cancelSubscriptionPlans();
                                            NavigatorHelper.of(context).pop();
                                            NavigatorHelper.of(context).pop();
                                          },
                                          child: Center(
                                            child: SubtitleText.small(
                                              text: AppText.msg_cancel_subscription,
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
          showSnackBar(context, message: AppText.success);
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
              text: AppText.lbl_kwd(args: [plan!.price.toString()]),
              isBold: true,
              color: AppColors.ExtraLight,
            ),
            SubtitleText(
              text: AppText.lbl_month,
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
                    _buildBenefitItem(plan.benefits?[index].benefit ?? ''),
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
                label: AppText.lbl_upgrade,
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
