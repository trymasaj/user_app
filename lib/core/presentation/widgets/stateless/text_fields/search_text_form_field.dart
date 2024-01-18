import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';

import 'package:masaj/core/presentation/widgets/stateless/text_fields/main_text_form_field.dart';

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
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.ACCENT_COLOR,
          ),
          cursorColor: AppColors.ACCENT_COLOR,
        );
}
