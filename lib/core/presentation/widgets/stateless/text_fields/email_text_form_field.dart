import 'package:flutter/services.dart';

import 'package:masaj/core/data/validator/validator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:masaj/core/presentation/widgets/stateless/text_fields/main_text_form_field.dart';

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
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r' '))]);
}
