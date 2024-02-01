import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/application/states/app_state.dart';
import 'package:masaj/core/presentation/widgets/stateless/state_widgets.dart';
import 'package:masaj/features/address/application/blocs/select_location_bloc/select_location_bloc.dart';
import 'package:masaj/features/address/domain/entities/city.dart';
import 'package:masaj/features/address/domain/entities/country.dart';

class CountryAndRegionSelector extends StatefulWidget {
  CountryAndRegionSelector({
    super.key,
    this.decoration = const InputDecoration(),
  });
  final InputDecoration decoration;

  @override
  State<CountryAndRegionSelector> createState() =>
      _CountryAndRegionSelectorState();
}

class _CountryAndRegionSelectorState extends State<CountryAndRegionSelector> {
  final border = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.w),
  );

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale == const Locale('ar');
    final controller = context.read<SelectLocationBloc>();
    return FormBuilder(
      child: Column(
        children: [
          BlocSelector<SelectLocationBloc, SelectLocationState,
                  DataLoadState<List<Country>>>(
              selector: (state) => state.countries,
              builder: (context, state) {
                return LoadStateHandler(
                  customState: state,
                  onTapRetry: controller.getCountries,
                  onData: (data) {
                    return FormBuilderDropdown<Country>(
                      name: 'country',
                      isExpanded: true,
                      initialValue:
                          controller.state.selectedCountry.toNullable(),
                      decoration: widget.decoration.copyWith(
                        hintText: "lbl_country".tr(),
                      ),
                      // value: state.selectedCountry.toNullable()?.id,
                      items: data
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (e.flagIcon != null)
                                    CachedNetworkImage(
                                        imageUrl: e.flagIcon!,
                                        height: 20.h,
                                        fit: BoxFit.cover,
                                        width: 20.w),
                                  SizedBox(width: 3.w),
                                  Text(
                                    isArabic ? e.nameAr ?? '' : e.nameEn ?? '',
                                    style: CustomTextStyles
                                        .bodyMediumOnErrorContainer,
                                  ),
                                  Spacer(),
                                  Text(
                                    e.code ?? '',
                                    style: CustomTextStyles
                                        .bodyMediumOnErrorContainer,
                                  ),
                                ],
                              )))
                          .toList(),
                      onChanged: (value) => controller.onCountryChanged(value!),
                    );
                  },
                );
              }),
          SizedBox(height: 18.h),
          BlocSelector<SelectLocationBloc, SelectLocationState,
                  DataLoadState<List<Area>>>(
              selector: (state) => state.cities,
              builder: (context, state) {
                return LoadStateHandler(
                  customState: state,
                  onTapRetry: controller.getCities,
                  onData: (data) {
                    return FormBuilderDropdown<Area>(
                      name: 'city',
                      initialValue: controller.state.selectedArea.toNullable(),
                      isExpanded: true,
                      decoration: widget.decoration.copyWith(
                        hintText: "lbl_region_area".tr(),
                      ),
                      items: data
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(width: 3),
                                  Text(
                                    isArabic ? e.name.nameAr : e.name.nameEn,
                                    style: CustomTextStyles
                                        .bodyMediumOnErrorContainer,
                                  ),
                                ],
                              )))
                          .toList(),
                      onChanged: (value) => controller.onCityChanged(value!),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
