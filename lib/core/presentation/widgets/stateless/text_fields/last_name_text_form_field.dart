import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/app_text.dart';
import 'package:masaj/core/data/validator/validator.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/main_text_form_field.dart';

class LastNameTextFormField extends MainTextFormField {
  LastNameTextFormField({
    super.key,
    required super.currentFocusNode,
    required FocusNode super.nextFocusNode,
    required super.currentController,
    super.margin = null,
    super.enabled,
  }) : super(
          validator: Validator().validateUserName,
          hintText: AppText.last_name,
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        );
}
