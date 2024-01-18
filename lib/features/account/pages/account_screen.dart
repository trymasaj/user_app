import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/border_tile.dart';
import 'package:masaj/features/account/bloc/account_bloc/account_bloc.dart';
import 'package:masaj/features/account/models/account_model.dart';
import 'package:masaj/features/account/pages/create_new_password_screen.dart';
import 'package:masaj/features/account/pages/my_profile_screen.dart';
import 'package:masaj/features/account/pages/phone_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';

  const AccountScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (context) => AccountBloc(AccountState(
        accountModelObj: const AccountModel(),
      )),
      child: const AccountScreen(),
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
                    text: 'lbl_profile'.tr(),
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
                    text: 'lbl_phone_number'.tr(),
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
                    text: 'lbl_change_password'.tr(),
                    onTap: () {
                      NavigatorHelper.of(context).pushNamed(
                        CreateNewPasswordScreen.routeName,
                      );
                    },
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.only(right: 7.w),
                  child: _buildTile(
                    image: ImageConstant.imgTrash,
                    text: 'lbl_delete_account'.tr(),
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
      title: Text('lbl_account'.tr()),
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
  }
}
