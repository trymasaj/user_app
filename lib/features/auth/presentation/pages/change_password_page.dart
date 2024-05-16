import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/overlay/show_snack_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/back_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_page.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/confirm_password_text_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/password_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/title_text.dart';
import 'package:masaj/features/auth/application/auth_cubit/auth_cubit.dart';

class ChangePasswordPage extends StatefulWidget {
  static const routeName = '/ChangePasswordPage';

  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _oldPasswordTextController;
  late final TextEditingController _newPasswordTextController;
  late final TextEditingController _confirmPasswordTextController;
  late final FocusNode _oldPasswordFocusNode;
  late final FocusNode _newPasswordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  bool _isAutoValidating = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _oldPasswordTextController = TextEditingController();
    _newPasswordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
    _oldPasswordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordTextController.dispose();
    _newPasswordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _oldPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight =
        mediaQueryData.size.height - mediaQueryData.padding.top;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError) showSnackBar(context, message: state.errorMessage);
        if (state.isLoggedIn) {
          NavigatorHelper.of(context).pop();
          showSnackBar(context, message: 'change_password_successfully');
        }
      },
      child: CustomAppPage(
        safeTop: true,
        safeBottom: false,
        withBackground: true,
        backgroundFit: BoxFit.fitWidth,
        backgroundPath: 'assets/images/forget_password_background.svg',
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Column(
                children: [
                  const CustomBackButton(),
                  const Spacer(flex: 3),
                  Expanded(
                    flex: 3,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        _buildChangePasswordMainText(context),
                        _buildChangePasswordSubText(context),
                        const SizedBox(height: 16.0),
                        _buildForm(),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  _buildLowerSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidateMode: _isAutoValidating
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: ListView(
        shrinkWrap: true,
        children: [
          PasswordTextFormField(
            currentFocusNode: _oldPasswordFocusNode,
            currentController: _oldPasswordTextController,
            nextFocusNode: _newPasswordFocusNode,
            hint: 'old_password',
          ),
          const SizedBox(height: 16.0),
          PasswordTextFormField(
            currentFocusNode: _newPasswordFocusNode,
            nextFocusNode: _confirmPasswordFocusNode,
            currentController: _newPasswordTextController,
            hint: 'new_password',
          ),
          const SizedBox(height: 16.0),
          ConfirmPasswordTextFormField(
            currentFocusNode: _confirmPasswordFocusNode,
            currentController: _confirmPasswordTextController,
            passwordController: _newPasswordTextController,
            hint: 'confirm_password',
          )
        ],
      ),
    );
  }

  Widget _buildChangePasswordMainText(BuildContext context) {
    return const TitleText.large(
      text: 'change_password_main',
      textAlign: TextAlign.center,
    );
  }

  Widget _buildChangePasswordSubText(BuildContext context) {
    return const SubtitleText.medium(
      text: 'change_password_sub',
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLowerSection(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.PRIMARY_COLOR,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSavePasswordButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSavePasswordButton(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return DefaultButton(
      label: 'save_new_password'.tr(),
      backgroundColor: AppColors.PRIMARY_COLOR,
      borderColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      isExpanded: true,
      onPressed: () async {
        if (_isNotValid()) return;
        await authCubit.changePassword(
          _oldPasswordTextController.text.trim(),
          _newPasswordTextController.text.trim(),
          _confirmPasswordTextController.text.trim(),
        );
      },
    );
  }

  bool _isNotValid() {
    if (!_formKey.currentState!.validate()) {
      setState(() => _isAutoValidating = true);
      return true;
    }
    return false;
  }

  void _goBackWithSuccess(BuildContext context) {
    NavigatorHelper.of(context).pop(true);
  }
}
