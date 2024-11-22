import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/account/pages/account_screen.dart';
import 'package:masaj/features/account/pages/manage_members_screen.dart';
import 'package:masaj/features/address/presentation/pages/address_page.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:masaj/features/gifts/presentaion/pages/gift_cards.dart';
import 'package:masaj/features/intro/presentation/pages/choose_language_page.dart';
import 'package:masaj/features/legal/pages/legal_screen.dart';
import 'package:masaj/features/medical_form/presentation/pages/medical_form_screen.dart';
import 'package:masaj/features/membership/presentaion/bloc/membership_cubit.dart';
import 'package:masaj/features/membership/presentaion/pages/memberships_screen.dart';
import 'package:masaj/features/settings_tab/bloc/settings_bloc/setting_bloc.dart';
import 'package:masaj/features/settings_tab/bloc/settings_bloc/setting_state.dart';
import 'package:masaj/features/settings_tab/models/settings_model.dart';
import 'package:masaj/features/settings_tab/widgets/setting_tile.dart';
import 'package:masaj/features/wallet/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:masaj/features/wallet/models/wallet_model.dart';
import 'package:masaj/features/wallet/pages/wallet_screen.dart';

// ignore_for_file: must_be_immutable
class SettingsTabPage extends StatefulWidget {
  const SettingsTabPage({super.key});

  static Widget builder(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => SettingsBloc(
          SettingsState(
            settingsSubscribedToMasajPlusModelObj:
                const SettingsSubscribedToMasajPlusModel(),
          ),
        ),
      ),
    ], child: const SettingsTabPage());
  }

  @override
  State<SettingsTabPage> createState() => _SettingsTabPageState();
}

class _SettingsTabPageState extends State<SettingsTabPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        _buildSettingsColumn(context),
        Expanded(
            child: SingleChildScrollView(
                child: Padding(
                    padding:
                        EdgeInsets.only(left: 23.w, right: 23.w, bottom: 5.h),
                    child: Column(children: [
                      Column(children: [
                        _buildGeneralColumn(context),
                        SizedBox(height: 14.h),
                        _buildReferCreditColumn(context),
                        SizedBox(height: 14.h),
                        _buildLegalColumn(context)
                      ]),
                      SizedBox(height: 10.h),
                      CustomElevatedButton(
                          onPressed: () async {
                            final isGuest =
                                context.read<AuthCubit>().state.isGuest;
                            if (!isGuest)
                              await context.read<AuthCubit>().logout(context);
                            else{
                              NavigatorHelper.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                            }
                          },
                          height: 48.h,
                          text: context.read<AuthCubit>().state.isLoggedIn
                              ? AppText.lbl_logout
                              : AppText.login,
                          buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF9ECEE)),
                          buttonTextStyle: CustomTextStyles.titleSmallPink700)
                    ]))))
      ]),
    ));
  }

  /// Section Widget
  Widget _buildSettingsColumn(BuildContext context) {
    final user = context.select((AuthCubit cubit) => cubit.state.user);
    final authState = context.read<AuthCubit>().state;
    final String? fullName = context.read<AuthCubit>().state.isLoggedIn
        ? user?.fullName
        : AppText.lbl_guest;
    return Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstant.imgGroup115),
                fit: BoxFit.cover)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppText.lbl_settings,
                  style:
                      CustomTextStyles.titleLargeOnPrimaryContainer_1.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                  ),
                ),
                // TextButton.icon(
                //   onPressed: () {},
                //   icon: SvgPicture.asset(ImageConstant.imgFluentChat24Regular),
                //   label: Text('lbl_support),
                // ),
              ],
            ),
          ),
          SizedBox(height: 13.h),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 23.w),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
              decoration: AppDecoration.outlineBlack90001
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // CustomImageView(
                    //     imagePath: ImageConstant.imgRectangle4236,
                    //     height: 60.adaptSize,
                    //     width: 60.adaptSize,
                    //     radius: BorderRadius.circular(8.w),
                    //     margin: EdgeInsets.only(top: 4.h, bottom: 5.h)),
                    Padding(
                        padding: EdgeInsets.only(left: 16.w, bottom: 2.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (authState.isLoggedIn)
                                BlocSelector<MembershipCubit, MembershipState,
                                    bool>(
                                  selector: (state) {
                                    return state.selectedSubscription?.id != 0;
                                  },
                                  builder: (context, isUpgraded) {
                                    if (isUpgraded)
                                      return Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 1.h),
                                          decoration: AppDecoration
                                              .gradientSecondaryContainerToPrimary
                                              .copyWith(
                                                  borderRadius:
                                                      BorderRadiusStyle
                                                          .roundedBorder8),
                                          child: Text(AppText.lbl_plus,
                                              style: CustomTextStyles
                                                  .labelLargeOnPrimaryContainer_1));
                                    return const SizedBox.shrink();
                                  },
                                ),
                              SizedBox(height: 1.h),
                              Text(fullName!.isNotEmpty ? fullName : '',
                                  style: CustomTextStyles.titleMediumGray90003),
                              SizedBox(height: 2.h),
                              SubtitleText.medium(
                                text: (user?.countryCode ?? '') +
                                    (user?.phone ?? ''),
                                textDirection: TextDirection.ltr,
                              )
                            ]))
                  ])),
          SizedBox(height: 13.h)
        ]));
  }

  /// Section Widget
  Widget _buildGeneralColumn(BuildContext context) {
    final bool isLoggedIn = context.read<AuthCubit>().state.isLoggedIn;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 19.h),
        decoration: AppDecoration.fillGray100
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppText.lbl_general,
                  style: CustomTextStyles.titleSmallOnPrimary_3),
              SizedBox(height: 5.h),
              isLoggedIn
                  ? Column(
                      children: [
                        SettingTile(
                            onTap: () {
                              NavigatorHelper.of(context)
                                  .pushNamed(AccountScreen.routeName);
                            },
                            text: AppText.lbl_account,
                            imagePath: ImageConstant.imgLockGray90003),
                        SettingTile(
                            onTap: () {
                              NavigatorHelper.of(context)
                                  .pushNamed(AddressPage.routeName);
                            },
                            text: AppText.lbl_addresses,
                            imagePath: ImageConstant.imgGroup1000003168),
                        SettingTile(
                            onTap: () {
                              NavigatorHelper.of(context)
                                  .pushNamed(MedicalFormScreen.routeName);
                            },
                            text: AppText.lbl_medical_form,
                            imagePath: ImageConstant.imgGroup1000003169),
                        SettingTile(
                            onTap: () {
                              NavigatorHelper.of(context)
                                  .pushNamed(ManageMembersScreen.routeName);
                            },
                            text: AppText.lbl_manage_members,
                            imagePath: ImageConstant.imgGroup1000003180),
                      ],
                    )
                  : const SizedBox(),
              SettingTile(
                  onTap: () {
                    final cubit = context.read<AuthCubit>();
                    if (cubit.state.isLoggedIn) {
                      NavigatorHelper.of(context).push(MaterialPageRoute(
                          builder: (context) => const MembershipPlansScreen()));
                    } else {
                      showSnackBar(context,
                          message: AppText.msg_in_order_to_accessing);
                    }
                  },
                  text: AppText.lbl_membership_plan,
                  imagePath: ImageConstant.imgCreditCard),
            ]));
  }

  void _goToGiftCardsPage() {
    NavigatorHelper.of(context).pushNamed(GiftCardsScreen.routeName);
  }

  /// Section Widget
  Widget _buildReferCreditColumn(BuildContext context) {
    final bool isLoggedIn = context.read<AuthCubit>().state.isLoggedIn;

    return isLoggedIn
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            decoration: AppDecoration.fillGray100
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppText.lbl_refer_credit,
                      style: CustomTextStyles.titleSmallOnPrimary_3),
                  SizedBox(height: 17.h),
                  BlocSelector<WalletBloc, WalletState, WalletModel>(
                    selector: (state) {
                      return state.walletBalance ?? WalletModel();
                    },
                    builder: (context, state) {
                      return SettingTile(
                        imagePath: ImageConstant.imgGroup1000003167,
                        text: AppText.lbl_my_wallet,
                        trailing: Text(
                            AppText.lbl_kwd(args: [state.balance.toString()]),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.onPrimary
                                    .withOpacity(0.7))),
                        onTap: () {
                          NavigatorHelper.of(context)
                              .pushNamed(WalletScreen.routeName);
                        },
                      );
                    },
                  ),
                  SettingTile(
                    text: AppText.lbl_gift_voucher,
                    imagePath: ImageConstant.imgGroup1000003170,
                    onTap: _goToGiftCardsPage,
                  ),
//                   SettingTile(
//                     text: 'lbl_refer_a_friend',
//                     imagePath: ImageConstant.imgSvgexport65,
//                     onTap: () {
// /*
//                   NavigatorHelper.of(context)
//                       .pushNamed(WalletScreen.routeName);
// */
//                     },
//                   ),
                ]))
        : const SizedBox();
  }

  /// Section Widget
  Widget _buildLegalColumn(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
        decoration: AppDecoration.fillGray100
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 3.h),
              Text(AppText.lbl_app,
                  style: CustomTextStyles.titleSmallOnPrimary_3),
              // SizedBox(height: 14.h),
              // SettingTile(
              //   text: AppText.lbl_notifications,
              //   imagePath: ImageConstant.imgGroup1000003171,
              //   onTap: () {},
              //   trailing: BlocSelector<SettingsBloc, SettingsState, bool?>(
              //       selector: (state) => state.isSelectedSwitch,
              //       builder: (context, isSelectedSwitch) {
              //         return CustomSwitch(
              //             value: isSelectedSwitch,
              //             onChange: (value) {
              //               context.read<SettingsBloc>().changeSwitch(value);
              //             });
              //       }),
              // ),
              SettingTile(
                text: AppText.lbl_language,
                imagePath: ImageConstant.imgGroup1000003172,
                onTap: () {
                  // we did the set state to update the ui after language change
                  NavigatorHelper.of(context)
                      .pushNamed(ChooseLanguagePage.routeName, arguments: true)
                      .then((value) => setState(() {}));
                },
              ),
              SettingTile(
                text: AppText.lbl_legal,
                imagePath: ImageConstant.imgGroup1000003173,
                onTap: () {
                  NavigatorHelper.of(context).pushNamed(LegalScreen.routeName);
                },
              ),
            ]));
  }
}
