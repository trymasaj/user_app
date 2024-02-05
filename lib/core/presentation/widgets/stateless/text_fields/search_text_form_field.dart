import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/main_text_form_field.dart';
import 'package:masaj/gen/assets.gen.dart';

class SearchTextFormField extends MainTextFormField {
  SearchTextFormField(
      {super.key,
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

          //    hintStyle: const TextStyle(
          //   fontSize: 14,
          //   fontWeight: FontWeight.w400,
          //   color: AppColors.PlaceholderColor,
          // ),

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
