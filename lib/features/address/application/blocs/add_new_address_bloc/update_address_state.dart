// ignore_for_file: must_be_immutable

part of 'update_address_bloc.dart';

/// Represents the state of AddNewAddress in the application.
class UpdateAddressState extends Equatable {
  const UpdateAddressState({
    required this.savedAddress,
    required this.latLng,
  });
  final Option<LatLng> latLng;
  final Option<Address> savedAddress;

  @override
  List<Object?> get props => [savedAddress,latLng];
  factory UpdateAddressState.initial() =>
      UpdateAddressState(savedAddress: none(), latLng: none());

  UpdateAddressState copyWith({
    Option<LatLng>? latLng,
    Option<Address>? savedAddress,
  }) {
    return UpdateAddressState(
      latLng: latLng ?? this.latLng,
      savedAddress: savedAddress ?? this.savedAddress,
    );
  }
}
