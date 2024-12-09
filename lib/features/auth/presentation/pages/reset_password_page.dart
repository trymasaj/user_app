import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/back_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/password_text_form_field.dart';

import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  static const routeName = '/resetPasswordPage';

  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _passwordTextController;
  late final TextEditingController _confirmPasswordTextController;

  late final FocusNode _confirmPasswordFocusNode;

  bool _isAutoValidating = false;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _confirmPasswordTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _confirmPasswordFocusNode.dispose();
    _confirmPasswordTextController.dispose();
    _passwordTextController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) {
          showSnackBar(context, message: state.errorMessage);
        } else if (state.isGuest) _goToLoginpage(context);
      },
      child: CustomAppPage(
        safeTop: true,
        safeBottom: true,
        child: Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const CustomBackButton(
                color: Colors.black,
              ),
              const SizedBox(height: 16.0),
              _buildResetPasswordMainText(context),
              const SizedBox(height: 8.0),
              _buildForgetPasswordSubText(context),
              const SizedBox(height: 16.0),
              _buildForm(),
              const SizedBox(height: 16.0),
              _buildResetPasswordButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordMainText(BuildContext context) {
    return const CustomText(
      text: 'reset_password',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildForgetPasswordSubText(BuildContext context) {
    return const CustomText(
      text: 'reset_password_sub',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.FONT_LIGHT_COLOR,
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: AppText.send,
      backgroundColor: Colors.transparent,
      onPressed: () async {
        if (_isNotValid()) return;
        if (context.read<AuthCubit>().state.user != null) {
          await authCubit.resetPassword(
              _passwordTextController.text,
              _confirmPasswordTextController.text,
              int.parse(context.read<AuthCubit>().state.user!.id!),
              context.read<AuthCubit>().state.user!.token!);
        }
      },
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PasswordTextFormField(
            currentFocusNode: _passwordFocusNode,
            currentController: _passwordTextController,
            nextFocusNode: _confirmPasswordFocusNode,
            hint: AppText.new_password,
          ),
          const SizedBox(height: 16.0),
          PasswordTextFormField(
            currentFocusNode: _confirmPasswordFocusNode,
            currentController: _confirmPasswordTextController,
            nextFocusNode: _confirmPasswordFocusNode,
            hint: AppText.confirm_new_password,
            validator: (value) {
              return Validator()
                  .validateConfPassword(_passwordTextController.text, value);
            },
          ),
        ],
      ),
    );
  }

  bool _isNotValid() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  void _goBackToLoginPage(BuildContext context, bool isSuccess) =>
      NavigatorHelper.of(context).pop(isSuccess);
  void _goToLoginpage(BuildContext context) {
    NavigatorHelper.of(context).pushNamedAndRemoveUntil(
      LoginPage.routeName,
      (route) => false,
    );
  }
}
