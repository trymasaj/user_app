import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/application/states/app_state.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/address/infrastructure/repos/address_repo.dart';
import 'package:meta/meta.dart';
part 'my_addresses_state.dart';

@LazySingleton()
class MyAddressesCubit extends BaseCubit<MyAddressesState> {
  MyAddressesCubit(this._repo) : super(MyAddressesState.initial());
  final AddressRepo _repo;


  Future<void> getAddresses() async {
    emit(state.copyWith(addresses: DataLoadState.loading()));
    final result = await _repo.getAddresses();
    emit(state.copyWith(addresses: DataLoadState.loaded(result)));
  }

  Future<void> add(Address result) async {
    await _repo.addAddress(result);
    final addresses = state.addressesData;

    if (result.isPrimary) {
      for (var i = 0; i < addresses.length; i++) {
        addresses[i] = addresses[i].copyWith(isPrimary: false);
      }
    }

    emit(state.copyWith(
        addresses: DataLoadState.loaded([...addresses, result])));
  }

  void setAsPrimary(int index) {
    final addresses = state.addressesData;

    for (var i = 0; i < addresses.length; i++) {
      addresses[i] = addresses[i].copyWith(isPrimary: false);
    }
    addresses[index] = addresses[index].copyWith(isPrimary: true);
    emit(state.copyWith(addresses: DataLoadState.loaded(addresses)));
  }

  Future<void> update(int index, Address result) async {
    await _repo.updateAddress(index, result);

    final addresses = state.addressesData;

    if (result.isPrimary) {
      for (var i = 0; i < addresses.length; i++) {
        addresses[i] = addresses[i].copyWith(isPrimary: false);
      }
    }
    addresses[index] = result;
    emit(state.copyWith(addresses: DataLoadState.loaded(addresses)));
  }

  Future<void> deleteAddress(int index) async {
    await _repo.deleteAddress(index);
    final addresses = state.addressesData;
    addresses.removeAt(index);
    emit(state.copyWith(addresses: DataLoadState.loaded(addresses)));
  }
}