// ignore_for_file: must_be_immutable

part of 'add_new_address_bloc.dart';

/// Represents the state of AddNewAddress in the application.
class AddNewAddressState extends Equatable {
  AddNewAddressState({
    this.nameEditTextController,
    this.blockEditTextController,
    this.streetEditTextController,
    this.avenueEditTextController,
    this.houseBuildingNoEditTextController,
    this.floorEditTextController,
    this.apartmentNoEditTextController,
    this.additionalDirectionEditTextController,
    this.isSelectedSwitch = false,
    this.addNewAddressModelObj,
  });

  TextEditingController? nameEditTextController;

  TextEditingController? blockEditTextController;

  TextEditingController? streetEditTextController;

  TextEditingController? avenueEditTextController;

  TextEditingController? houseBuildingNoEditTextController;

  TextEditingController? floorEditTextController;

  TextEditingController? apartmentNoEditTextController;

  TextEditingController? additionalDirectionEditTextController;

  AddNewAddressModel? addNewAddressModelObj;

  bool isSelectedSwitch;

  @override
  List<Object?> get props => [
        nameEditTextController,
        blockEditTextController,
        streetEditTextController,
        avenueEditTextController,
        houseBuildingNoEditTextController,
        floorEditTextController,
        apartmentNoEditTextController,
        additionalDirectionEditTextController,
        isSelectedSwitch,
        addNewAddressModelObj,
      ];
  AddNewAddressState copyWith({
    TextEditingController? nameEditTextController,
    TextEditingController? blockEditTextController,
    TextEditingController? streetEditTextController,
    TextEditingController? avenueEditTextController,
    TextEditingController? houseBuildingNoEditTextController,
    TextEditingController? floorEditTextController,
    TextEditingController? apartmentNoEditTextController,
    TextEditingController? additionalDirectionEditTextController,
    bool? isSelectedSwitch,
    AddNewAddressModel? addNewAddressModelObj,
  }) {
    return AddNewAddressState(
      nameEditTextController:
          nameEditTextController ?? this.nameEditTextController,
      blockEditTextController:
          blockEditTextController ?? this.blockEditTextController,
      streetEditTextController:
          streetEditTextController ?? this.streetEditTextController,
      avenueEditTextController:
          avenueEditTextController ?? this.avenueEditTextController,
      houseBuildingNoEditTextController: houseBuildingNoEditTextController ??
          this.houseBuildingNoEditTextController,
      floorEditTextController:
          floorEditTextController ?? this.floorEditTextController,
      apartmentNoEditTextController:
          apartmentNoEditTextController ?? this.apartmentNoEditTextController,
      additionalDirectionEditTextController:
          additionalDirectionEditTextController ??
              this.additionalDirectionEditTextController,
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      addNewAddressModelObj:
          addNewAddressModelObj ?? this.addNewAddressModelObj,
    );
  }
}
