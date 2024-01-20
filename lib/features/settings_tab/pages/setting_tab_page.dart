import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/features/account/pages/account_screen.dart';
import 'package:masaj/features/account/pages/manage_members_screen.dart';
import 'package:masaj/features/address/pages/map_location_picker.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/intro/presentation/pages/choose_language_page.dart';
import 'package:masaj/features/legal/pages/legal_screen.dart';
import 'package:masaj/features/medical_form/pages/medical_form_screen.dart';
import 'package:masaj/features/settings_tab/bloc/settings_bloc/setting_bloc.dart';
import 'package:masaj/features/settings_tab/bloc/settings_bloc/setting_state.dart';
import 'package:masaj/features/settings_tab/models/settings_model.dart';
import 'package:masaj/features/settings_tab/widgets/setting_tile.dart';
import 'package:masaj/features/wallet/pages/wallet_screen.dart';

// ignore_for_file: must_be_immutable
class SettingsTabPage extends StatelessWidget {
  const SettingsTabPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc(SettingsState(
            settingsSubscribedToMasajPlusModelObj:
                const SettingsSubscribedToMasajPlusModel())),
        child: const SettingsTabPage());
  }

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
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                          },
                          height: 48.h,
                          text: 'lbl_logout'.tr(context: context),
                          buttonStyle: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF9ECEE)),
                          buttonTextStyle: CustomTextStyles.titleSmallPink700)
                    ]))))
      ]),
    ));
  }

  /// Section Widget
  Widget _buildSettingsColumn(BuildContext context) {
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
                  'lbl_settings'.tr(),
                  style:
                      CustomTextStyles.titleLargeOnPrimaryContainer_1.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset(ImageConstant.imgFluentChat24Regular),
                  label: Text('lbl_support'.tr()),
                ),
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
                    CustomImageView(
                        imagePath: ImageConstant.imgRectangle4236,
                        height: 60.adaptSize,
                        width: 60.adaptSize,
                        radius: BorderRadius.circular(8.w),
                        margin: EdgeInsets.only(top: 4.h, bottom: 5.h)),
                    Padding(
                        padding: EdgeInsets.only(left: 16.w, bottom: 2.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 1.h),
                                  decoration: AppDecoration
                                      .gradientSecondaryContainerToPrimary
                                      .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder8),
                                  child: Text('lbl_plus'.tr(),
                                      style: CustomTextStyles
                                          .labelLargeOnPrimaryContainer_1)),
                              SizedBox(height: 1.h),
                              Text('lbl_jasmine_sanchez'.tr(),
                                  style: CustomTextStyles.titleMediumGray90003),
                              SizedBox(height: 2.h),
                              Text('lbl_965231131123'.tr(),
                                  style: theme.textTheme.bodySmall)
                            ]))
                  ])),
          SizedBox(height: 13.h)
        ]));
  }

  /// Section Widget
  Widget _buildGeneralColumn(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 19.h),
        decoration: AppDecoration.fillGray100
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('lbl_general'.tr(),
                  style: CustomTextStyles.titleSmallOnPrimary_3),
              SizedBox(height: 5.h),
              SettingTile(
                  onTap: () {
                    NavigatorHelper.of(context)
                        .pushNamed(AccountScreen.routeName);
                  },
                  text: 'lbl_account',
                  imagePath: ImageConstant.imgLockGray90003),
              SettingTile(
                  onTap: () {
                    print('helooo');
                    NavigatorHelper.of(context)
                        .pushNamed(MapLocationPicker.routeName);
                  },
                  text: 'lbl_addresses',
                  imagePath: ImageConstant.imgGroup1000003168),
              SettingTile(
                  onTap: () {
                    NavigatorHelper.of(context)
                        .pushNamed(MedicalFormScreen.routeName);
                  },
                  text: 'lbl_medical_form',
                  imagePath: ImageConstant.imgGroup1000003169),
              SettingTile(
                  onTap: () {
                    NavigatorHelper.of(context)
                        .pushNamed(ManageMembersScreen.routeName);
                  },
                  text: 'lbl_manage_members',
                  imagePath: ImageConstant.imgGroup1000003180),
              SettingTile(
                  onTap: () {
/*
                    NavigatorHelper.of(context)
                        .pushNamed(ManageMembersScreen.routeName);
*/
                  },
                  text: 'lbl_membership_plan',
                  imagePath: ImageConstant.imgCreditCard),
            ]));
  }

  /// Section Widget
  Widget _buildReferCreditColumn(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: AppDecoration.fillGray100
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('lbl_refer_credit'.tr(),
                  style: CustomTextStyles.titleSmallOnPrimary_3),
              SizedBox(height: 17.h),
              SettingTile(
                imagePath: ImageConstant.imgGroup1000003167,
                text: 'lbl_my_wallet'.tr(),
                trailing: Text('lbl_30_000_kwd'.tr(),
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onPrimary.withOpacity(0.7))),
                onTap: () {
                  NavigatorHelper.of(context).pushNamed(WalletScreen.routeName);
                },
              ),
              SettingTile(
                text: 'lbl_gift_voucher',
                imagePath: ImageConstant.imgGroup1000003170,
                onTap: () {},
              ),
              SettingTile(
                text: 'lbl_refer_a_friend',
                imagePath: ImageConstant.imgSvgexport65,
                onTap: () {
/*
                  NavigatorHelper.of(context)
                      .pushNamed(WalletScreen.routeName);
*/
                },
              ),
            ]));
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
              Text('lbl_app'.tr(),
                  style: CustomTextStyles.titleSmallOnPrimary_3),
              SizedBox(height: 14.h),
              SettingTile(
                text: 'lbl_notifications',
                imagePath: ImageConstant.imgGroup1000003171,
                onTap: () {},
                trailing: BlocSelector<SettingsBloc, SettingsState, bool?>(
                    selector: (state) => state.isSelectedSwitch,
                    builder: (context, isSelectedSwitch) {
                      return CustomSwitch(
                          value: isSelectedSwitch,
                          onChange: (value) {
                            context.read<SettingsBloc>().changeSwitch(value);
                          });
                    }),
              ),
              SettingTile(
                text: 'lbl_language',
                imagePath: ImageConstant.imgGroup1000003172,
                onTap: () {
                  NavigatorHelper.of(context)
                      .pushNamed(ChooseLanguagePage.routeName);
                },
              ),
              SettingTile(
                text: 'lbl_legal',
                imagePath: ImageConstant.imgGroup1000003173,
                onTap: () {
                  NavigatorHelper.of(context).pushNamed(LegalScreen.routeName);
                },
              ),
            ]));
  }
}
