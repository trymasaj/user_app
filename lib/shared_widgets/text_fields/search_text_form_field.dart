import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../res/style/app_colors.dart';

import 'abstract/main_text_form_field.dart';

class SearchTextFormField extends MainTextFormField {
  SearchTextFormField(
      {super.key,
      required super.currentFocusNode,
      required super.currentController,
      super.margin = null,
      super.enabled,
      super.style,
      super.onChanged})
      : super(
          hintText: 'search_hint'.tr(),
          keyboardType: TextInputType.emailAddress,
          validator: null,
          fillColor: Colors.white,
          hintColor: AppColors.ACCENT_COLOR,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.ACCENT_COLOR,
          ),
          cursorColor: AppColors.ACCENT_COLOR,
        );
}
