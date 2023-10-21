import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/validator.dart';
import 'abstract/main_text_form_field.dart';

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
          hintText: 'last_name'.tr(),
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
        );
}
