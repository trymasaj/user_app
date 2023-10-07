import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';

import 'abstract/main_text_form_field.dart';

class SearchTextFormField extends MainTextFormField {
  SearchTextFormField(
      {Key? key,
      required final FocusNode currentFocusNode,
      required final TextEditingController currentController,
      final EdgeInsetsGeometry? margin,
      bool enabled = true,
      final TextStyle? style,
      final void Function(String)? onChanged})
      : super(
          key: key,
          currentController: currentController,
          currentFocusNode: currentFocusNode,
          hintText: 'search_hint'.tr(),
          keyboardType: TextInputType.emailAddress,
          margin: margin,
          enabled: enabled,
          validator: null,
          fillColor: Colors.white,
          style: style,
          hintColor: AppColors.ACCENT_COLOR,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.ACCENT_COLOR,
          ),
          onChanged: onChanged,
          cursorColor: AppColors.ACCENT_COLOR,
        );
}
