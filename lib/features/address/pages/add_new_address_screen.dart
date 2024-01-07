import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/utils/validation_functions.dart';
import 'package:masaj/core/widgets/custom_outlined_button.dart';
import 'package:masaj/core/widgets/custom_text_form_field.dart';

import '../bloc/add_new_address_bloc/add_new_address_bloc.dart';
import '../models/add_new_address_model.dart';
import 'package:flutter/material.dart';

class AddNewAddressScreen extends StatelessWidget {
  static const routeName = '/add-new-address';

  AddNewAddressScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<AddNewAddressBloc>(
      create: (context) => AddNewAddressBloc(AddNewAddressState(
        addNewAddressModelObj: AddNewAddressModel(),
      )),
      child: AddNewAddressScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              children: [
                SizedBox(height: 23.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        bottom: 5.h,
                      ),
                      child: Column(
                        children: [
                          _buildMaskStack(context),
                          SizedBox(height: 16.h),
                          _buildNameEditText(context),
                          SizedBox(height: 16.h),
                          _buildBlockEditText(context),
                          SizedBox(height: 16.h),
                          _buildStreetEditText(context),
                          SizedBox(height: 16.h),
                          _buildAvenueEditText(context),
                          SizedBox(height: 16.h),
                          _buildHouseBuildingNoEditText(context),
                          SizedBox(height: 16.h),
                          _buildFloorEditText(context),
                          SizedBox(height: 16.h),
                          _buildApartmentNoEditText(context),
                          SizedBox(height: 16.h),
                          _buildAdditionalDirectionEditText(context),
                          SizedBox(height: 16.h),
                          _buildFrameRow(context),
                        ],
                      ),
                    ),
                  ),
                ),
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
      title: Text("lbl_add_new_address2".tr()),
    );
  }

  /// Section Widget
  Widget _buildChangeLocationButton(BuildContext context) {
    return CustomOutlinedButton(
      height: 36.h,
      width: 137.w,
      text: "lbl_change_location".tr(),
      buttonStyle: CustomButtonStyles.outlineGray,
      alignment: Alignment.center,
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
          CustomImageView(
            imagePath: ImageConstant.imgDemo,
            height: 135.h,
            width: 327.w,
            radius: BorderRadius.circular(
              12.w,
            ),
            alignment: Alignment.center,
          ),
          _buildChangeLocationButton(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState,
        TextEditingController?>(
      selector: (state) => state.nameEditTextController,
      builder: (context, nameEditTextController) {
        return CustomTextFormField(
          controller: nameEditTextController,
          hintText: "msg_address_nickname".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
          validator: (value) {
            if (!isText(value)) {
              return "err_msg_please_enter_valid_text".tr();
            }
            return null;
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildBlockEditText(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState,
        TextEditingController?>(
      selector: (state) => state.blockEditTextController,
      builder: (context, blockEditTextController) {
        return CustomTextFormField(
          controller: blockEditTextController,
          hintText: "lbl_block".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildStreetEditText(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState,
        TextEditingController?>(
      selector: (state) => state.streetEditTextController,
      builder: (context, streetEditTextController) {
        return CustomTextFormField(
          controller: streetEditTextController,
          hintText: "lbl_street".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildAvenueEditText(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState,
        TextEditingController?>(
      selector: (state) => state.avenueEditTextController,
      builder: (context, avenueEditTextController) {
        return CustomTextFormField(
          controller: avenueEditTextController,
          hintText: "lbl_avenue".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildHouseBuildingNoEditText(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState,
        TextEditingController?>(
      selector: (state) => state.houseBuildingNoEditTextController,
      builder: (context, houseBuildingNoEditTextController) {
        return CustomTextFormField(
          controller: houseBuildingNoEditTextController,
          hintText: "msg_house_building_no".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildFloorEditText(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState,
        TextEditingController?>(
      selector: (state) => state.floorEditTextController,
      builder: (context, floorEditTextController) {
        return CustomTextFormField(
          controller: floorEditTextController,
          hintText: "lbl_floor".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildApartmentNoEditText(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState,
        TextEditingController?>(
      selector: (state) => state.apartmentNoEditTextController,
      builder: (context, apartmentNoEditTextController) {
        return CustomTextFormField(
          controller: apartmentNoEditTextController,
          hintText: "lbl_apartment_no".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildAdditionalDirectionEditText(BuildContext context) {
    return BlocSelector<AddNewAddressBloc, AddNewAddressState,
        TextEditingController?>(
      selector: (state) => state.additionalDirectionEditTextController,
      builder: (context, additionalDirectionEditTextController) {
        return CustomTextFormField(
          controller: additionalDirectionEditTextController,
          hintText: "msg_additional_direction".tr(),
          hintStyle: CustomTextStyles.bodyMediumBluegray40001_1,
          textInputAction: TextInputAction.done,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildFrameRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "msg_set_as_primary_address".tr(),
          style: CustomTextStyles.bodyMediumGray90003,
        ),
        BlocSelector<AddNewAddressBloc, AddNewAddressState, bool?>(
          selector: (state) => state.isSelectedSwitch,
          builder: (context, isSelectedSwitch) {
            return CustomSwitch(
              value: isSelectedSwitch,
              onChange: (value) {},
            );
          },
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_save".tr(),
      margin: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: 32.h,
      ),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientSecondaryContainerToPrimaryDecoration,
    );
  }
}
