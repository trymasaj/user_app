import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/address/domain/entities/suggestion_address.dart';

class LocationPickTextField extends StatelessWidget {
  const LocationPickTextField(
      {super.key,
      required this.onSelected,
      required this.onSearch,
      required this.focusNode});
  final ValueSetter<SuggestionAddress> onSelected;
  final FocusNode focusNode;
  final Future<List<SuggestionAddress>> Function(String search) onSearch;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.w),
    );
    return TypeAheadField<SuggestionAddress>(
      suggestionsCallback: onSearch,
      focusNode: focusNode,
      hideOnEmpty: true,
      builder: (context, controller, focusNode) {
        return TextField(
            controller: controller,
            focusNode: focusNode,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              prefixIcon: SvgPicture.asset(
                ImageConstant.imgSearch,
                height: 5.h,
                width: 5.w,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 40.w,
                minHeight: 20.h,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
              hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
              filled: true,
              fillColor: const Color(0xffF6F6F6),
              enabledBorder: border,
              focusedBorder: border,
              border: border,
              disabledBorder: border,
              errorBorder: border,
              focusedErrorBorder: border,
              hintText: 'search_location'.tr(),
            ));
      },
      debounceDuration: const Duration(milliseconds: 700),
      itemBuilder: (context, city) {
        return Column(
          children: [
            ListTile(
              title: Text(city.address),
            ),
            const Divider()
          ],
        );
      },
      onSelected: onSelected,
    );
  }
}
