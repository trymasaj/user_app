import 'dart:developer';

import 'package:masaj/res/style/app_colors.dart';

import '../../core/exceptions/redundant_request_exception.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

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
                (message as String).tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: AppColors.BACKGROUND_COLOR),
              ),
            ),
            if (action != null) action,
          ],
        ),
      ));

  scaffoldMessenger.showSnackBar(snackBar);
}
