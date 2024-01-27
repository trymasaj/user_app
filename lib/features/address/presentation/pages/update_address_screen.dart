import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/data/validator/validation_functions.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_outlined_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_text_form_field.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/features/address/application/blocs/add_new_address_bloc/update_address_bloc.dart';
import 'package:masaj/features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart';
import 'package:masaj/features/address/application/blocs/select_location_bloc/select_location_bloc.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:masaj/features/address/presentation/widgets/country_and_region_selector.dart';
import 'package:masaj/features/address/presentation/pages/map_location_picker.dart';

class UpdateAddressArguments {
  final AddressUpdater updater;

  UpdateAddressArguments({required this.updater});
}

class UpdateAddressScreen extends StatefulWidget {
  final UpdateAddressArguments arguments;

  static const routeName = '/add-new-address';

  const UpdateAddressScreen({super.key, required this.arguments});
  static Widget builder(UpdateAddressArguments arguments) => BlocProvider(
        create: (context) => getIt<UpdateAddressCubit>(param1: arguments),
        child: UpdateAddressScreen(arguments: arguments),
      );
  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  UpdateAddressArguments get arguments => widget.arguments;
  AddressUpdater get updater => arguments.updater;
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      formKey.currentState!.patchValue(updater.patchedFormValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateAddressCubit, UpdateAddressState>(
      listenWhen: (previous, current) {
        return previous.savedAddress != current.savedAddress;
      },
      listener: (context, state) {
        state.savedAddress.fold(
          () {},
          (address) {
            Navigator.of(context).pop(address);
          },
        );
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              bottom: 5.h,
            ),
            child: Column(
              children: [
                SizedBox(height: 23.h),
                _buildMaskStack(context),
                SizedBox(height: 16.h),
                _buildNameEditText(context),
                SizedBox(height: 16.h),
                CountryAndRegionSelector(),
                SizedBox(height: 16.h),
                _buildBlockEditText(context),
                SizedBox(height: 16.h),
                _buildStreetEditText(context),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(child: _buildAvenueEditText(context)),
                    SizedBox(width: 16.w),
                    Expanded(child: _buildHouseBuildingNoEditText(context)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildFloorEditText(context)),
                    SizedBox(width: 16.w),
                    Expanded(child: _buildApartmentNoEditText(context)),
                  ],
                ),
                _buildAdditionalDirectionEditText(context),
                SizedBox(height: 16.h),
                _buildFrameRow(context),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildSaveButton(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(widget.arguments.updater.addressPageTitle.tr()),
    );
  }

  /// Section Widget
  Widget _buildChangeLocationButton(BuildContext context) {
    return CustomOutlinedButton(
      height: 36.h,
      width: 137.w,
      text: 'lbl_change_location'.tr(),
      buttonStyle: CustomButtonStyles.outlineGray,
      alignment: Alignment.center,
      onPressed: () async {
        print(
            'in ${context.read<UpdateAddressCubit>().state.latLng.toNullable()}');
        final result = await Navigator.of(context).pushNamed(
          MapLocationPicker.routeName,
          arguments: MapLocationPickerArguments(
            initialLatlng:
                context.read<UpdateAddressCubit>().state.latLng.toNullable(),
          ),
        ) as LatLng?;
        if (result != null) {
          print('out ${result}');
          /*

           */
          context.read<UpdateAddressCubit>().updateLatLng(result);
        }
      },
    );
  }

  /// Section Widget
  Widget _buildMaskStack(BuildContext context) {
    return SizedBox(
      height: 135.h,
      width: 327.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const IgnorePointer(
            child: GoogleMap(
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                initialCameraPosition: CameraPosition(
                    zoom: 15, target: LatLng(31.0922607, 29.7541743))),
          ),
          _buildChangeLocationButton(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return FormBuilderTextField(
      decoration: InputDecoration(
        hintText: 'msg_address_nickname'.tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
      name: Address.nickNameKey,
    );
  }

  /// Section Widget
  Widget _buildBlockEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      decoration: InputDecoration(
        hintText: 'lbl_block'.tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
      name: Address.blockKey,
    );
  }

  /// Section Widget
  Widget _buildStreetEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      decoration: InputDecoration(
        hintText: 'lbl_street'.tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
      name: Address.streetKey,
    );
  }

  /// Section Widget
  Widget _buildAvenueEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      decoration: InputDecoration(
        helperText: '',
        hintText: 'lbl_avenue'.tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
      name: Address.avenueKey,
    );
  }

  /// Section Widget
  Widget _buildHouseBuildingNoEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      name: Address.buildingKey,
      decoration: InputDecoration(
        helperText: '',
        hintText: 'msg_house_building_no'.tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
    );
  }

  /// Section Widget
  Widget _buildFloorEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      decoration: InputDecoration(
        helperText: '',
        hintText: 'lbl_floor'.tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
      name: Address.floorKey,
    );
  }

  /// Section Widget
  Widget _buildApartmentNoEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
      name: Address.apartmentKey,
      decoration: InputDecoration(
        helperText: '',
        hintText: 'lbl_apartment_no'.tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
    );
  }

  /// Section Widget
  Widget _buildAdditionalDirectionEditText(BuildContext context) {
    return FormBuilderTextField(
      name: Address.additionalDirectionKey,
      validator: FormBuilderValidators.compose([]),
      decoration: InputDecoration(
        hintText: 'msg_additional_direction'.tr(),
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
      ),
      textInputAction: TextInputAction.done,
    );
  }

  /// Section Widget
  Widget _buildFrameRow(BuildContext context) {
    return FormBuilderSwitch(
      initialValue: false,
      decoration: InputDecoration(
        hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      name: Address.isPrimaryKey,
      title: Text(
        'msg_set_as_primary_address'.tr(),
        style: CustomTextStyles.bodyMediumGray90003,
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return DefaultButton(
      label: 'lbl_save'.tr(),
      margin: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: 32.h,
      ),
      onPressed: () {
        final isValid = formKey.currentState!.saveAndValidate();
        if (!isValid) return Future.value();
        return context
            .read<UpdateAddressCubit>()
            .save(Address.fromMap(formKey.currentState!.value).copyWith(
              country: context
                  .read<SelectLocationBloc>()
                  .state
                  .selectedCountry
                  .toNullable()!
                  .nameEn!,
              region: context
                  .read<SelectLocationBloc>()
                  .state
                  .selectedCity
                  .toNullable()!
                  .name
                  .nameEn,
            ));
      },
    );
  }
}
