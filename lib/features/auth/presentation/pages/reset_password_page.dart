import 'package:easy_localization/easy_localization.dart';
import 'package:masaj/shared_widgets/stateless/custom_text.dart';
import 'package:masaj/shared_widgets/text_fields/password_text_form_field.dart';
import '../../../../shared_widgets/stateless/back_button.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth_cubit/auth_cubit.dart';

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
        if (state.isError)
          showSnackBar(context, message: state.errorMessage);
        else if (state.isInitial) _goBackToLoginPage(context, true);
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
      label: 'send',
      backgroundColor: Colors.transparent,
      onPressed: () async {
        // if (_isNotValid()) return;
        // await authCubit.forgetPassword(_emailTextController.text.trim());
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
            hint: 'new_password'.tr(),
          ),
          const SizedBox(height: 16.0),
          PasswordTextFormField(
            currentFocusNode: _passwordFocusNode,
            currentController: _passwordTextController,
            nextFocusNode: _confirmPasswordFocusNode,
            hint: 'confirm_new_password'.tr(),
            validator: (value) {
              if (value != _passwordTextController.text) {
                return 'passwords_not_match'.tr();
              }
              return null;
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
}
