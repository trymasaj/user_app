import 'package:masaj/shared_widgets/stateless/custom_text.dart';
import '../../../../shared_widgets/stateless/back_button.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared_widgets/text_fields/email_text_form_field.dart';
import '../blocs/auth_cubit/auth_cubit.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const routeName = '/ForgetPasswordPage';
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailTextController;
  late final FocusNode _emailFocusNode;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailTextController = TextEditingController();
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _emailFocusNode.dispose();
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
              _buildForgetPasswordMainText(context),
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

  Widget _buildForgetPasswordMainText(BuildContext context) {
    return const CustomText(
      text: 'forget_password',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildForgetPasswordSubText(BuildContext context) {
    return const CustomText(
      text: 'forget_password_sub',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.FONT_LIGHT_COLOR,
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: 'continue',
      backgroundColor: Colors.transparent,
      onPressed: () async {
        if (_isNotValid()) return;
        await authCubit.forgetPassword(_emailTextController.text.trim());
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
          EmailTextFormField(
            currentFocusNode: _emailFocusNode,
            currentController: _emailTextController,
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
