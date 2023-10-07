import 'package:flutter/gestures.dart';
import '../../../../shared_widgets/stateless/back_button.dart';
import '../../../../shared_widgets/stateless/subtitle_text.dart';
import '../../../../shared_widgets/stateless/title_text.dart';
import 'package:size_helper/size_helper.dart';

import '../../../../core/utils/navigator_helper.dart';
import '../../../../res/style/app_colors.dart';
import '../../../../shared_widgets/stateless/custom_app_page.dart';
import '../../../../shared_widgets/stateful/default_button.dart';
import '../../../../shared_widgets/other/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared_widgets/text_fields/email_text_form_field.dart';
import '../blocs/auth_cubit/auth_cubit.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const routeName = '/ForgetPasswordPage';
  const ForgetPasswordPage({Key? key}) : super(key: key);

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
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight =
        mediaQueryData.size.height - mediaQueryData.padding.top;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.isError)
          showSnackBar(context, message: state.errorMessage);
        else if (state.isInitial) _goBackToLoginPage(context, true);
      },
      child: CustomAppPage(
        safeTop: true,
        safeBottom: false,
        withBackground: true,
        backgroundFit: BoxFit.fitWidth,
        backgroundPath: 'lib/res/assets/forget_password_background.svg',
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Column(
                children: [
                  const CustomBackButton(),
                  const Spacer(flex: 4),
                  Expanded(
                    flex: 3,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        _buildForgetPasswordMainText(context),
                        _buildForgetPasswordSubText(context),
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

  Widget _buildForgetPasswordMainText(BuildContext context) {
    return const TitleText.large(
      text: 'forget_password_main',
      textAlign: TextAlign.center,
    );
  }

  Widget _buildForgetPasswordSubText(BuildContext context) {
    return const SubtitleText.medium(
      text: 'forget_password_sub',
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLowerSection(BuildContext context) {
    return Expanded(
      flex: 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.PRIMARY_COLOR,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildResetPasswordButton(context),
              const SizedBox(height: 24.0),
              _buildLoginIRememberPasswordButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordButton(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 16.0,
            tabletLarge: 18.0,
            desktopSmall: 21.0,
          ),
        );

    final authCubit = context.read<AuthCubit>();

    return DefaultButton(
      label: 'reset_password'.tr(),
      labelStyle: textStyle,
      backgroundColor: Colors.transparent,
      icon: const Icon(Icons.arrow_forward),
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      iconLocation: DefaultButtonIconLocation.End,
      borderColor: Colors.white,
      onPressed: () async {
        if (_isNotValid()) return;
        await authCubit.forgetPassword(_emailTextController.text.trim());
      },
    );
  }

  Widget _buildLoginIRememberPasswordButton(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: context.sizeHelper(
            mobileExtraLarge: 14.0,
            tabletLarge: 16.0,
            desktopSmall: 18.0,
          ),
        );
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: 'already_have_account_message'.tr(), style: textStyle),
          TextSpan(
            text: 'login'.tr(),
            style: textStyle.copyWith(fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _goBackToLoginPage(context, false),
          ),
        ],
      ),
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
          const TitleText(text: 'your_email'),
          const SizedBox(height: 8.0),
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
