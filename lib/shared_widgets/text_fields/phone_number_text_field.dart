import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:size_helper/size_helper.dart';

import '../../res/style/app_colors.dart';

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField({
    Key? key,
    required this.currentFocusNode,
    required this.nextFocusNode,
    required this.currentController,
    this.margin,
    this.initialValue,
    required this.onInputChanged,
    this.isEnabled = true,
    this.hint,
  }) : super(key: key);

  final FocusNode currentFocusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController currentController;
  final EdgeInsetsGeometry? margin;
  final PhoneNumber? initialValue;
  final ValueChanged<PhoneNumber> onInputChanged;
  final bool isEnabled;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final currentLocal = context.locale;
    const textStyle = TextStyle(
      fontSize: 14.0,
      fontFamily: 'Poppins',
      color: Colors.black,
      fontWeight: FontWeight.w400,
    );
    return Container(
      margin: margin,
      child: InternationalPhoneNumberInput(
        //locale: CurrentUser().languageCode,
        // countries: const ['SA', 'EG', 'AE', 'KW'],
        isEnabled: isEnabled,
        focusNode: currentFocusNode,
        textFieldController: currentController,
        locale: currentLocal.languageCode,
        cursorColor: Colors.black,
        textStyle: textStyle,
        selectorTextStyle: textStyle,
        inputDecoration: InputDecoration(
          fillColor:
              isEnabled ? const Color(0xFFF6F6F6) : AppColors.GREY_NORMAL_COLOR,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          hintText: hint ?? 'phone_number'.tr(),
          hintStyle: textStyle.copyWith(
            color: const Color(0xFF8C8C8C),
          ),
          counterText: '',
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),

        autoValidateMode: AutovalidateMode.onUserInteraction,
        initialValue: initialValue ?? PhoneNumber(isoCode: 'SA'),
        selectorConfig: const SelectorConfig(
          trailingSpace: false,
          leadingPadding: 0.0,
          selectorType: PhoneInputSelectorType.DIALOG,
        ),
        searchBoxDecoration: InputDecoration(
          hintText: 'search_by_country_name_or_code'.tr(),
        ),
        spaceBetweenSelectorAndTextField: 8.0,
        errorMessage: 'invalid_phone_number'.tr(),
        hintText: '50.......',
        onInputChanged: onInputChanged,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(nextFocusNode),
      ),
    );
  }
}
