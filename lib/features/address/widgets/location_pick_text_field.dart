import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/features/address/models/decoded_address.dart';

class LocationPickTextField extends StatelessWidget {
  const LocationPickTextField(
      {Key? key,
      required this.onSelected,
      required this.onSearch,
      required this.focusNode})
      : super(key: key);
  final ValueSetter<GeoCodedAddress> onSelected;
  final FocusNode focusNode;
  final Future<List<GeoCodedAddress>> Function(String search) onSearch;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 0.0),
        borderRadius: BorderRadius.zero);
    return TypeAheadField<GeoCodedAddress>(
      suggestionsCallback: onSearch,
      focusNode: focusNode,
      hideOnEmpty: true,
      builder: (context, controller, focusNode) {
        return TextField(
            controller: controller,
            focusNode: focusNode,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                hintText: 'search_location'.tr(),
                focusedBorder: border,
                border: border,
                errorBorder: border,
                disabledBorder: border,
                enabledBorder: border,
                fillColor: Colors.white,
                filled: true));
      },
      itemBuilder: (context, city) {
        return ListTile(
          title: Text(city.address),
        );
      },
      onSelected: onSelected,
    );
  }
}
