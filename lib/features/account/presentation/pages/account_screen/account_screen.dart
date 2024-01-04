import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/navigator_helper.dart';
import 'package:masaj/core/widgets/app_bar/appbar_subtitle.dart';
import 'package:masaj/core/widgets/app_bar/appbar_title_iconbutton.dart';
import 'package:masaj/core/widgets/border_tile.dart';
import 'package:masaj/features/account/presentation/pages/change_password/create_new_password_one_screen.dart';
import 'package:masaj/features/account/presentation/pages/my_profile_screen/my_profile_screen.dart';
import 'package:masaj/features/account/presentation/pages/phone_screen/phone_screen.dart';

import 'bloc/account_bloc.dart';
import 'models/account_model.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (context) => AccountBloc(AccountState(
        accountModelObj: AccountModel(),
      ))
        ..add(AccountInitialEvent()),
      child: AccountScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 26.h,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 7.w),
                  child: _buildTile(
                    image: ImageConstant.imgLockGray90003,
                    text: "lbl_profile".tr(),
                    onTap: () {
                      NavigatorHelper.of(context).pushNamed(
                        MyProfileScreen.routeName,
                      );
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.only(right: 7.w),
                  child: _buildTile(
                    image: ImageConstant.imgPhPhoneThin,
                    text: "lbl_phone_number".tr(),
                    onTap: () {
                      NavigatorHelper.of(context).pushNamed(
                        PhoneScreen.routeName,
                      );
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.only(right: 7.w),
                  child: _buildTile(
                    image: ImageConstant.imgLockGray9000320x20,
                    text: "lbl_change_password".tr(),
                    onTap: () {
                      NavigatorHelper.of(context).pushNamed(
                        CreateNewPasswordOneScreen.routeName,
                      );
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.only(right: 7.w),
                  child: _buildTile(
                    image: ImageConstant.imgTrash,
                    text: "lbl_delete_account".tr(),
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("lbl_account".tr()),
    );
  }

/*
  Widget _buildTile({
    required String image,
    required String text,
    required VoidCallback onTap,
  }) {
    return BorderTile(
      image: image,
      text: text,
      onTap: onTap,
    );
  }
*/
  /// Common widget
  Widget _buildTile({
    required String image,
    required String text,
    required VoidCallback onTap,
  }) {
    return BorderTile(
      image: image,
      text: text,
      onTap: onTap,
    );
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 17.w,
        vertical: 16.h,
      ),
      decoration: AppDecoration.outlineBluegray1001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: image,
            height: 20.adaptSize,
            width: 20.adaptSize,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              text,
              style: theme.textTheme.titleSmall!.copyWith(
                color: appTheme.gray90003,
              ),
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRightOnprimary,
            height: 17.adaptSize,
            width: 17.adaptSize,
            radius: BorderRadius.circular(
              8.w,
            ),
            margin: EdgeInsets.symmetric(vertical: 2.h),
          ),
        ],
      ),
    );
  }
}
