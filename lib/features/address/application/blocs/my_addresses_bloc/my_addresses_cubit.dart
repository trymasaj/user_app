import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/application/states/app_state.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:meta/meta.dart';
part 'my_addresses_state.dart';

@LazySingleton()
class MyAddressesCubit extends BaseCubit<MyAddressesState> {
  MyAddressesCubit() : super(MyAddressesState.initial());

  Future<void> getAddresses() async {
    emit(state.copyWith(addresses: DataLoadState.loading()));
    await Future.delayed(Duration(seconds: 3));
    emit(state.copyWith(
        addresses: DataLoadState.loaded([
      Address(
        id: 1,
        type: AddressType.home,
        additionalDirection: "Ev",
        apartment: "Daire",
        avenue: "Cadde",
        block: "Blok",
        building: "Bina",
        country: "Türkiye",
        floor: 'Kat',
        nickName: "Ev",
        region: "Bölge",
        street: "Sokak",
      ),
      Address(
        id: 2,
        type: AddressType.work,
        additionalDirection: "İş",
        apartment: "Daire",
        avenue: "Cadde",
        block: "Blok",
        building: "Bina",
        country: "Türkiye",
        floor: 'Kat',
        nickName: "İş",
        region: "Bölge",
        street: "Sokak",
      ),
    ])));
  }

  void add(Address result) {
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

  void update(int index, Address result) {
    final addresses = state.addressesData;

    if (result.isPrimary) {
      for (var i = 0; i < addresses.length; i++) {
        addresses[i] = addresses[i].copyWith(isPrimary: false);
      }
    }
    addresses[index] = result;
    emit(state.copyWith(addresses: DataLoadState.loaded(addresses)));
  }

  void deleteAddress(int index) {
    final addresses = state.addressesData;
    addresses.removeAt(index);
    emit(state.copyWith(addresses: DataLoadState.loaded(addresses)));
  }
}
