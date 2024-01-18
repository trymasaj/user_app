import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/main_text_form_field.dart';

class FirstNameTextFormField extends MainTextFormField {
  FirstNameTextFormField({
    super.key,
    required super.currentFocusNode,
    required FocusNode super.nextFocusNode,
    required super.currentController,
    super.margin = null,
    super.enabled,
  }) : super(
          validator: Validator().validateUserName,
          hintText: 'first_name'.tr(),
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        );
}
