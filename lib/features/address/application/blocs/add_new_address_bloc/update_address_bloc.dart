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

abstract class UpdateAddressCubit extends BaseCubit<UpdateAddressState> {
  final AddressRepo repo;

  UpdateAddressCubit(this.repo) : super(UpdateAddressState.initial());

  Future<void> save(Address address);

  void updateLatLng(LatLng latLng) {
    emit(state.copyWith(
      latLng: some(latLng),
    ));
  }
}


class EditAddressCubit extends UpdateAddressCubit {
  EditAddressCubit(super.repo, );
  late Address oldAddress;

  void init(Address oldAddress){
    this.oldAddress = oldAddress;
  }

  @override
  Future<void> save(Address address) async {
    final result = await repo.updateAddress(
        oldAddress.id, address.copyWith(latLng: state.latLng.toNullable()));
    if (result == null) return;
    emit(state.copyWith(
      savedAddress: some(result),
    ));
  }
}

@Injectable()
class AddAddressCubit extends UpdateAddressCubit {
  AddAddressCubit(super.repo);
  @override
  Future<void> save(Address address) async {
    final result = await repo
        .addAddress(address.copyWith(latLng: state.latLng.toNullable()));
    if (result == null) return;
    emit(state.copyWith(
      savedAddress: some(result),
    ));
  }
}
