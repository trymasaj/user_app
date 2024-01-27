import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:masaj/core/app_export.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/address/presentation/pages/update_address_screen.dart';
import 'package:masaj/features/address/infrastructure/repos/address_repo.dart';

part 'update_address_state.dart';

@Injectable()
class UpdateAddressCubit extends BaseCubit<UpdateAddressState> {
  final UpdateAddressArguments arguments;

  UpdateAddressCubit(@factoryParam this.arguments)
      : super(UpdateAddressState.initial());

  Future<void> save(Address address) async {
    final result = address.copyWith(latLng: state.latLng.toNullable());
    await arguments.updater.onSave(address);
    emit(state.copyWith(

      savedAddress: some(result),
    ));
  }

  void updateLatLng(LatLng latLng) {
    emit(state.copyWith(
      latLng: some(latLng),
    ));
  }
}

abstract class AddressUpdater {
  final AddressRepo repo;
  bool get isPrimaryAddress;
  String get addressPageTitle;
  const AddressUpdater(this.repo);
  Map<String, dynamic> get patchedFormValue;
  Future<Address?> onSave(
    Address address,
  );
}

@Injectable()
class CreateAddressUpdater extends AddressUpdater {
  CreateAddressUpdater(super.repo);
  String get addressPageTitle => 'lbl_add_new_address2';

  @override
  Future<Address?> onSave(
    Address address,
  ) async {
    final result = await repo.addAddress(address);
    return address;
  }

  @override
  Map<String, dynamic> get patchedFormValue => kDebugMode
      ? {
          Address.buildingKey: 'test building',
          Address.apartmentKey: 'test apartment',
          Address.floorKey: 'test floor',
          Address.avenueKey: 'test avenue',
          Address.streetKey: 'test street',
          Address.blockKey: 'test block',
          Address.regionKey: 'test region',
          Address.countryKey: 'test country',
          Address.additionalDirectionKey: 'test additional direction',
          Address.nickNameKey: 'test nick name',
        }
      : {};

  @override
  // TODO: implement isPrimaryAddress
  bool get isPrimaryAddress => false;
}

@Injectable()
class UpdateAddressUpdater extends AddressUpdater {
  UpdateAddressUpdater(super.repo, @factoryParam this.oldAddress);
  final Address oldAddress;

  @override
  Future<Address?> onSave(Address address) async {
    final result = await repo.updateAddress(oldAddress.id, address);
    return address;
  }

  @override
  Map<String, dynamic> get patchedFormValue => oldAddress.toMap();

  @override
  // TODO: implement isPrimaryAddress
  bool get isPrimaryAddress => oldAddress.isPrimary;

  @override
  // TODO: implement addressPageTitle
  String get addressPageTitle => 'lbl_update_address';
}
