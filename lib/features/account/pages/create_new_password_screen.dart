import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/validation_functions.dart';
import 'package:masaj/core/widgets/custom_text_form_field.dart';
import 'package:masaj/core/widgets/password_text_field.dart';

import '../bloc/create_new_password_bloc/create_new_password_bloc.dart';
import '../models/create_new_password_model.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  static const routeName = '/change-password';

  CreateNewPasswordScreen({super.key});

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<CreateNewPasswordOneBloc>(
      create: (context) =>
          CreateNewPasswordOneBloc(CreateNewPasswordState.initial()),
      child: CreateNewPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                controller: TextEditingController(),
                hint: 'msg_current_password',
              ),
              SizedBox(height: 20.h),
              PasswordTextField(
                controller: TextEditingController(),
                hint: 'lbl_new_password',
              ),
              SizedBox(height: 20.h),
              PasswordTextField(
                controller: TextEditingController(),
                hint: 'msg_confirm_new_password',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'lbl_change_password'.tr(),
      ),
    );
  }
}
