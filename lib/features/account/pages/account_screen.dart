import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/di_wrapper.dart';
import 'package:masaj/core/data/logger/abs_logger.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/border_tile.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/features/account/bloc/account_bloc/account_bloc.dart';
import 'package:masaj/features/account/data/models/contact_us_message_model.dart';
import 'package:masaj/features/account/models/account_model.dart';
import 'package:masaj/features/account/pages/create_new_password_screen.dart';
import 'package:masaj/features/account/pages/my_profile_screen.dart';
import 'package:masaj/features/account/pages/phone_screen.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/data/managers/auth_manager.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';
import 'package:pretty_dialog/pretty_dialog.dart';


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
    return BlocBuilder<AuthCubit, AuthState>(
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
                    text: AppText.lbl_profile,
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
                    text: AppText.lbl_phone_number,
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
                    text: AppText.lbl_change_password,
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
                    text: AppText.lbl_delete_account,
                    color: AppColors.ERROR_COLOR,
                    onTap: () async {
                      deleteAccount(context);
                    },
                  ),
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        );
      }
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppText.lbl_account,
      centerTitle: true,
    );
  }

  /// Common widget
  Widget _buildTile({
    required String image,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return BorderTile(
      image: image,
      text: text,
      onTap: onTap,
      color: color,
    );
  }


  Future<void> deleteAccount(BuildContext context) async {

    
    var yes = await PrettyDialog.showActionDialog(
      context,
      title: AppText.are_you_sure,
      subTitle: AppText.confirm_delete_account,
      yesText: AppText.ok,
      cancelText: AppText.cancel,
      
    );

    if(yes != true) return;

    final user = context.read<AuthCubit>().state.user;

    
    try {
      var success = await DI.find<AuthManager>().deleteAccount();
      if(success){
        showSnackBar(context, message: AppText.msg_order_has_been_sent);
        //
        NavigatorHelper.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
                (_) => false);
      }
    } on RedundantRequestException catch (e) {
      DI.find<AbsLogger>().error('[$runtimeType].deleteAccount()' ,e);
    } catch (e) {
      DI.find<AbsLogger>().error('[$runtimeType].deleteAccount()' ,e);
      showSnackBar(context, message: AppText.msg_something_went_wrong);
    }
  }


}
