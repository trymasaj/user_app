part of 'my_addresses_cubit.dart';

@immutable
class MyAddressesState {
  final DataLoadState<List<Address>> addresses;
  final int selectedAddressIndex;

  MyAddressesState(
      {required this.addresses, required this.selectedAddressIndex});

  factory MyAddressesState.initial() => MyAddressesState(
      selectedAddressIndex: 0, addresses: DataLoadState.initial());
  List<Address> get addressesData =>
      (addresses as DataLoadLoadedState<List<Address>>).data;
  MyAddressesState copyWith({
    DataLoadState<List<Address>>? addresses,
    int? selectedAddressIndex,
  }) {
    return MyAddressesState(
      selectedAddressIndex: selectedAddressIndex ?? this.selectedAddressIndex,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyAddressesState &&
          runtimeType == other.runtimeType &&
          addresses == other.addresses &&
          selectedAddressIndex == other.selectedAddressIndex;

  @override
  int get hashCode => addresses.hashCode ^ selectedAddressIndex.hashCode;
}
