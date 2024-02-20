import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/data/di/injection_setup.dart';
import 'package:masaj/core/data/di/injector.dart';
import 'package:masaj/core/presentation/colors/app_colors.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_app_bar.dart';
import 'package:masaj/core/presentation/widgets/stateless/custom_outlined_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/default_button.dart';
import 'package:masaj/core/presentation/widgets/stateless/subtitle_text.dart';
import 'package:masaj/features/address/application/blocs/add_new_address_bloc/update_address_bloc.dart';
import 'package:masaj/features/address/application/blocs/select_location_bloc/select_location_bloc.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:masaj/features/address/presentation/widgets/country_and_region_selector.dart';
import 'package:masaj/features/address/presentation/pages/map_location_picker.dart';
import 'package:masaj/features/auth/application/country_cubit/country_cubit.dart';
import 'package:masaj/features/auth/application/country_cubit/country_state.dart';

class EditAddressArguments {
  final Address oldAddress;

  EditAddressArguments({required this.oldAddress});
}

class EditAddressScreen extends StatefulWidget {
  final EditAddressArguments arguments;
  static const routeName = '/edit-address';
  const EditAddressScreen({super.key, required this.arguments});
  static Widget builder(EditAddressArguments arguments) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<EditAddressCubit>(param1: arguments.oldAddress),
          ),
          BlocProvider(
            create: (context) => getIt<InitiallySelectAreaCubit>(
                param1: SelectAreaArguments(
              countryId: arguments.oldAddress.country!.id!,
              areaId: arguments.oldAddress.area.id,
            ))
              ..init(),
          ),
          BlocProvider(
            create: (context) => Injector().countryCubit,
          ),
        ],
        child: EditAddressScreen(arguments: arguments),
      );

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      formKey.currentState!.patchValue(widget.arguments.oldAddress.toMap());
    });
  }

  @override
  Widget build(BuildContext context) {
    return UpdateAddressScreen<EditAddressCubit, InitiallySelectAreaCubit>(
      formKey: formKey,
      title: 'lbl_edit_address'.tr(),
    );
  }
}

class AddAddressScreen extends StatefulWidget {
  static const routeName = '/add-new-address';

  const AddAddressScreen({
    super.key,
  });

  static Widget builder() => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AddAddressCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<NotInitiallySelectAreaCubit>()..init(),
          ),
          BlocProvider(
            create: (context) => Injector().countryCubit,
          ),
        ],
        child: const AddAddressScreen(),
      );

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  final formKey = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      formKey.currentState!.patchValue(kDebugMode
          ? {
              Address.buildingKey: 'test building',
              Address.apartmentKey: 'test apartment',
              Address.floorKey: 'test floor',
              Address.avenueKey: 'test avenue',
              Address.streetKey: 'test street',
              Address.blockKey: 'test block',
              Address.regionKey: 'test region',
              Address.countryKey: 'test country',
              Address.additionalDetailsKey: 'test additional direction',
              Address.nickNameKey: 'test nick name',
            }
          : {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return UpdateAddressScreen<AddAddressCubit, NotInitiallySelectAreaCubit>(
      formKey: formKey,
      title: 'lbl_add_new_address'.tr(),
    );
  }
}

class UpdateAddressScreen<T extends UpdateAddressCubit,
    A extends SelectAreaCubit> extends StatelessWidget {
  final String title;
  final GlobalKey<FormBuilderState> formKey;

  const UpdateAddressScreen({
    super.key,
    required this.title,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<T, UpdateAddressState>(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 23.h),
                _buildMaskStack(context),
                SizedBox(height: 16.h),
                _buildNameEditText(context),
                SizedBox(height: 16.h),
                CountryAndRegionSelector<A>(
                  form: formKey,
                ),
                _buildCountryError(),
                SizedBox(height: 16.h),
                _buildBlockEditText(context),
                SizedBox(height: 16.h),
                _buildStreetEditText(context),
                SizedBox(height: 16.h),
                _buildGoogleMapAddressEditText(context),
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
                SizedBox(height: 8.h),
                _buildFrameRow(context),
                SizedBox(height: 90.h),
              ],
            ),
          ),
        ),
        floatingActionButton: _buildSaveButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildCountryError() {
    return BlocSelector<CountryCubit, CountryState, bool>(
      selector: (state) {
        return state.showCountryError;
      },
      builder: (context, state) {
        log(state.toString());
        log('state');

        return state
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: const SubtitleText(
                  text: 'msg_please_select_your2',
                  color: AppColors.ERROR_COLOR,
                  subtractedSize: 4,
                ),
              )
            : const SizedBox();
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: title,
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
        await _goToMap(context);
      },
    );
  }

  Future<void> _goToMap(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(
      MapLocationPicker.routeName,
      arguments: MapLocationPickerArguments(
        initialLatlng: context.read<T>().state.latLng.toNullable(),
      ),
    ) as MapLocationPickerResult?;
    if (result != null) {
      context.read<T>().updateLatLng(result.latLng);
      formKey.currentState!.patchValue({
        Address.googleMapAddressKey: result.address,
      });
    }
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
      style: CustomTextStyles.bodyMediumGray90003,
      decoration: InputDecoration(
        hintText: 'msg_address_nickname'.tr(),
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.ERROR_COLOR),
        hintStyle: const TextStyle(fontSize: 14),
      ),
      name: Address.nickNameKey,
    );
  }

  /// Section Widget
  Widget _buildBlockEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'empty_field_not_valid'.tr()),
      ]),
      style: CustomTextStyles.bodyMediumGray90003,
      decoration: InputDecoration(
        hintText: 'lbl_block'.tr(),
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.ERROR_COLOR),
        hintStyle: const TextStyle(fontSize: 14),
      ),
      name: Address.blockKey,
    );
  }

  /// Section Widget
  Widget _buildStreetEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'empty_field_not_valid'.tr()),
      ]),
      style: CustomTextStyles.bodyMediumGray90003,
      decoration: InputDecoration(
        hintText: 'lbl_street'.tr(),
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.ERROR_COLOR),
        hintStyle: const TextStyle(fontSize: 14),
      ),
      name: Address.streetKey,
    );
  }

  Widget _buildGoogleMapAddressEditText(BuildContext context) {
    return FormBuilderTextField(
      readOnly: true,
      onTap: () async => _goToMap(context),
      style: CustomTextStyles.bodyMediumGray90003,
      validator: FormBuilderValidators.compose([]),
      decoration: InputDecoration(
        hintText: 'lbl_address'.tr(),
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.ERROR_COLOR),
        hintStyle: const TextStyle(fontSize: 14),
      ),
      name: Address.googleMapAddressKey,
    );
  }

  /// Section Widget
  Widget _buildAvenueEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'empty_field_not_valid'.tr()),
      ]),
      style: CustomTextStyles.bodyMediumGray90003,
      decoration: InputDecoration(
        helperText: '',
        hintText: 'lbl_avenue'.tr(),
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.ERROR_COLOR),
        hintStyle: const TextStyle(fontSize: 14),
      ),
      name: Address.avenueKey,
    );
  }

  /// Section Widget
  Widget _buildHouseBuildingNoEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'empty_field_not_valid'.tr()),
      ]),
      name: Address.buildingKey,
      style: CustomTextStyles.bodyMediumGray90003,
      decoration: InputDecoration(
        helperText: '',
        hintText: 'msg_house_building_no'.tr(),
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.ERROR_COLOR),
        hintStyle: const TextStyle(fontSize: 13),
      ),
    );
  }

  /// Section Widget
  Widget _buildFloorEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'empty_field_not_valid'.tr()),
      ]),
      style: CustomTextStyles.bodyMediumGray90003,
      decoration: InputDecoration(
        helperText: '',
        hintText: 'lbl_floor'.tr(),
        hintMaxLines: 1,
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.ERROR_COLOR),
        hintStyle: const TextStyle(fontSize: 14),
      ),
      name: Address.floorKey,
    );
  }

  /// Section Widget
  Widget _buildApartmentNoEditText(BuildContext context) {
    return FormBuilderTextField(
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'empty_field_not_valid'.tr()),
      ]),
      name: Address.apartmentKey,
      style: CustomTextStyles.bodyMediumGray90003,
      decoration: InputDecoration(
        helperText: '',
        hintText: 'lbl_apartment_no'.tr(),
        errorStyle: const TextStyle(fontSize: 12, color: AppColors.ERROR_COLOR),
        hintStyle: const TextStyle(fontSize: 14),
      ),
    );
  }

  /// Section Widget
  Widget _buildAdditionalDirectionEditText(BuildContext context) {
    return FormBuilderTextField(
      name: Address.additionalDetailsKey,
      validator: FormBuilderValidators.compose([]),
      style: CustomTextStyles.bodyMediumGray90003,
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
      activeColor: AppColors.PRIMARY_COLOR,
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
      padding: EdgeInsets.symmetric(horizontal: 150.w),
      onPressed: () async {
        final countryCubit = context.read<CountryCubit>();
        final isValid = formKey.currentState!.saveAndValidate();
        final addressMap = formKey.currentState!.value;

        if (!isValid ||
            (addressMap['country'] == null || addressMap['area'] == null)) {
          countryCubit.setCountryError(true);
          return Future.value();
        } else {
          countryCubit.setCountryError(false);
        }
        await context.read<T>().save(Address.fromMap(addressMap));
        final savedAddress = context.read<T>().state.savedAddress;
        //if saved address is primary true then call set as current in country cubit this will help you when you add first address or update primary address
        savedAddress.fold(() {}, (address) async {
          if (address.isPrimary) {
            await countryCubit.setCurrentAddress(address);
          }
        });
      },
    );
  }
}
