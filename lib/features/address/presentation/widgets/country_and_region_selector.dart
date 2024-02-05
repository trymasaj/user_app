import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/application/states/app_state.dart';
import 'package:masaj/core/presentation/widgets/stateless/state_widgets.dart';
import 'package:masaj/features/address/application/blocs/select_location_bloc/select_location_bloc.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/address/domain/entities/city.dart';
import 'package:masaj/features/address/domain/entities/country.dart';

class CountryAndRegionSelector<T extends SelectAreaCubit>
    extends StatelessWidget {
  CountryAndRegionSelector({
    super.key,
    this.decoration = const InputDecoration(),
    required this.form,
  });
  final InputDecoration decoration;
  final GlobalKey<FormBuilderState> form;

  final border = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10.w),
  );

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale == const Locale('ar');
    final controller = context.read<T>();
    return Column(
      children: [
        BlocSelector<T, SelectAreaState, DataLoadState<List<Country>>>(
            selector: (state) => state.countries,
            builder: (context, state) {
              return LoadStateHandler(
                customState: state,
                onTapRetry: controller.getCountries,
                onData: (data) {
                  return FormBuilderDropdown<Country>(
                    key: form,
                    validator: FormBuilderValidators.required(),
                    valueTransformer: (value) {
                      return value?.toMap();
                    },
                    name: Address.countryKey,
                    isExpanded: true,
                    decoration: decoration.copyWith(
                      hintText: 'lbl_country'.tr(),
                    ),
                    initialValue: controller.state.selectedCountry.toNullable(),
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
                                const Spacer(),
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
        BlocSelector<T, SelectAreaState, DataLoadState<List<Area>>>(
            selector: (state) => state.cities,
            builder: (context, state) {
              return LoadStateHandler(
                customState: state,
                onTapRetry: controller.getAreas,
                onData: (data) {
                  return FormBuilderDropdown<Area>(
                    validator: (value) {
                      
                      if (value == null) {
                        return 'error_required'.tr();
                      }
                      return 'null';
                    },
                    valueTransformer: (value) {
                      return value?.toMap();
                    },
                    name: Address.areaKey,
                    initialValue: controller.state.selectedArea.toNullable(),
                    isExpanded: true,
                    decoration: decoration.copyWith(
                      hintText: 'lbl_region_area'.tr(),
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
                                  e.name,
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
    );
  }
}
