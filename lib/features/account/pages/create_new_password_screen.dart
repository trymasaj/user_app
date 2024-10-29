import 'package:flutter/material.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateful/password_text_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';

import 'package:masaj/features/account/bloc/create_new_password_bloc/create_new_password_bloc.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  static const routeName = '/change-password';

  CreateNewPasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<CreateNewPasswordOneBloc>(
      create: (context) =>
          CreateNewPasswordOneBloc(CreateNewPasswordState.initial()),
      child: CreateNewPasswordScreen(),
    );
  }

  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isAccountError)
          showSnackBar(context, message: state.errorMessage);
        if (state.isChangePassword) {
          NavigatorHelper.of(context).pop();
          showSnackBar(context, message: AppText.password_changed);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 23.h,
            ),
            child: Column(
              children: [
                PasswordTextField(
                  controller: _passwordController,
                  hint: 'msg_current_password',
                  validator: (value) => Validator().validatePassword(value),
                ),
                SizedBox(height: 20.h),
                PasswordTextField(
                  controller: _newPasswordController,
                  validator: (value) => Validator().validatePassword(value),
                  hint: 'lbl_new_password',
                ),
                SizedBox(height: 20.h),
                PasswordTextField(
                  controller: _newPasswordConfirmController,
                  validator: (value) => Validator()
                      .validateConfPassword(_newPasswordController.text, value),
                  hint: 'msg_confirm_new_password',
                ),
                SizedBox(height: 20.h),
                DefaultButton(
                    label: AppText.lbl_continue,
                    isExpanded: true,
                    onPressed: () async {
                      final cubit = context.read<AuthCubit>();
                      if (_isValid())
                        await cubit.changePassword(
                          _passwordController.text.trim(),
                          _newPasswordController.text.trim(),
                          _newPasswordConfirmController.text.trim(),
                        );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isValid() {
    if (_formKey.currentState!.validate()) {
      if (_newPasswordController.text == _newPasswordConfirmController.text) {
        return true;
      }
      return false;
    } else
      return false;
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppText.lbl_change_password,
      centerTitle: true,
    );
  }
}
