part of 'my_addresses_cubit.dart';

@immutable
class MyAddressesState {
  final DataLoadState<List<Address>> addresses;

  MyAddressesState({required this.addresses});

  factory MyAddressesState.initial() =>
      MyAddressesState(addresses: DataLoadState.initial());
  List<Address> get addressesData =>
      (addresses as DataLoadLoadedState<List<Address>>).data;
  MyAddressesState copyWith({
    DataLoadState<List<Address>>? addresses,
  }) {
    return MyAddressesState(
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is MyAddressesState &&
          runtimeType == other.runtimeType &&
          addresses == other.addresses;

  @override
  int get hashCode => super.hashCode ^ addresses.hashCode;
}
