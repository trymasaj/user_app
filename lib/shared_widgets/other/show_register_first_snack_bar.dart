import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/navigator_helper.dart';
import '../../features/auth/presentation/pages/sign_up_step_1_page.dart';
import '../../res/style/app_colors.dart';
import 'show_snack_bar.dart';

void showRegisterFirstSnackbar(BuildContext context) => showSnackBar(
      context,
      message: 'register_first',
      action: _buildRegisterButton(context),
    );

Widget _buildRegisterButton(BuildContext context) {
  return InkWell(
    child: Text(
      'login'.tr(),
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.BACKGROUND_COLOR,
          ),
    ),
    onTap: () => _goToSignUpStep1Page(context),
  );
}

Future<void> _goToSignUpStep1Page(BuildContext context) =>
    NavigatorHelper.of(context).pushNamed(SignUpStep1Page.routeName);
