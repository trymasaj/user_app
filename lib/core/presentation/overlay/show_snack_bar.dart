import 'dart:developer';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/domain/exceptions/redundant_request_exception.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/navigation/navigator_helper.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/auth/presentation/pages/login_page.dart';

void showSnackBar(BuildContext context,
    {required dynamic message,
    Widget? action,
    EdgeInsetsGeometry? margin =
        const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 48.0)}) {
  if (message is RedundantRequestException) return log(message.toString());

  final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
  if (scaffoldMessenger == null) return;

  scaffoldMessenger.clearSnackBars();

  message = message.toString();

  const snackBarDuration = Duration(seconds: 4);

  final snackBar = SnackBar(
      duration: snackBarDuration,
      margin: margin,
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.ACCENT_COLOR,
      content: Directionality(
        textDirection: context.locale == const Locale('en')
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.BACKGROUND_COLOR),
              ),
            ),
            if (action != null) action,
          ],
        ),
      ));

  scaffoldMessenger.showSnackBar(snackBar);
}

void showGuestSnackBar(
  BuildContext context,
) {
  showSnackBar(context,
      message: AppText.msg_in_order_to_accessing,
      action: TextButton(
        child: SubtitleText(
          text: AppText.login,
          color: AppColors.PRIMARY_COLOR,
        ),
        onPressed: () {
          NavigatorHelper.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (_) => false);
        },
      ));
}
