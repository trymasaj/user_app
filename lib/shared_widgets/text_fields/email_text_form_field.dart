import 'package:flutter/services.dart';

import '../../core/utils/validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'abstract/main_text_form_field.dart';

class EmailTextFormField extends MainTextFormField {
  EmailTextFormField({
    super.key,
    required super.currentFocusNode,
    super.nextFocusNode,
    required super.currentController,
    super.margin = null,
    super.enabled,
  }) : super(
            validator: Validator().validateEmail,
            hintText: 'email_address'.tr(),
            keyboardType: TextInputType.emailAddress,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r" "))]);
}
