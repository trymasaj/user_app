// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/main_text_form_field.dart';
import 'package:masaj/gen/assets.gen.dart';

class SearchTextFormField extends MainTextFormField {
  SearchTextFormField(
      {super.key,
      required EdgeInsetsGeometry contentPaddig,
      required super.currentFocusNode,
      required super.currentController,
      super.margin = null,
      super.enabled,
      super.style,
      super.readOnly,
      super.onTap,
      super.onChanged})
      : super(
          hintText: 'search'.tr(),
          keyboardType: TextInputType.emailAddress,
          validator: null,
          fillColor: AppColors.ExtraLight,
          hintColor: AppColors.PlaceholderColor,
          contentPadding: contentPaddig,

          //    hintStyle: const TextStyle(
          //   fontSize: 14,
          //   fontWeight: FontWeight.w400,
          //   color: AppColors.PlaceholderColor,
          // ),

          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              Assets.images.imgSearch,
              color: AppColors.PlaceholderColor,
            ),
          ),
          cursorColor: AppColors.ACCENT_COLOR,
        );
  SearchTextFormField.servicesSearchField(
      {super.key,
      required super.currentFocusNode,
      required super.currentController,
      super.margin = null,
      super.enabled,
      super.style,
      super.contentPadding,
      super.isSearch = true,
      super.readOnly,
      super.onTap,
      super.onChanged})
      : super(
          hintText: 'search'.tr(),
          keyboardType: TextInputType.emailAddress,
          validator: null,
          fillColor: Colors.white,
          hintColor: AppColors.PlaceholderColor,
          borderColor: const Color(0xffEEEEEE),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              Assets.images.imgSearch,
              color: AppColors.PlaceholderColor,
            ),
          ),
          cursorColor: AppColors.ACCENT_COLOR,
        );
}

class BasicTextFiled extends MainTextFormField {
  BasicTextFiled(
      {required super.currentFocusNode,
      super.onChanged,
      super.style,
      super.readOnly,
      super.onTap,
      super.margin,
      super.enabled,
      super.contentPadding,
      super.isSearch,
      super.nextFocusNode,
      super.keyboardType,
      super.maxLength,
      super.inputFormatters,
      super.expanded,
      super.maxLines,
      super.borderColor,
      super.hintColor,
      super.enableSuggestions,
      super.showScrollbar,
      super.obscureText,
      super.suffixIcon,
      super.fillColor,
      super.cursorColor,
      super.hintStyle,
      super.decoration,
      super.prefixIcon,
      super.textCapitalization,
      super.key,
      required super.currentController,
      required super.hintText,
      super.validator});
}
