import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/address/domain/entities/address.dart';
import 'package:masaj/features/address/domain/entities/country.dart';
import 'package:masaj/features/address/infrastructure/repos/address_repo.dart';
import 'package:masaj/features/auth/application/country_cubit/country_state.dart';
import 'package:masaj/features/auth/data/repositories/auth_repository.dart';
import 'package:collection/collection.dart';

class CountryCubit extends BaseCubit<CountryState> {
  CountryCubit(
    this._authRepository,
    this._addressRepo,
  ) : super(const CountryState());

  final AuthRepository _authRepository;
  final AddressRepo _addressRepo;

  Future<void> getCurrentCountry() async {
    try {
      emit(state.copyWith(status: CountryStateStatus.loading));
      final currentCountry = await _authRepository.getCurrentCountry();
      emit(state.copyWith(
        status: CountryStateStatus.loaded,
        currentCountry: currentCountry,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: CountryStateStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> setCurrentCountry(Country country) async {
    try {
      emit(state.copyWith(status: CountryStateStatus.loading));
      await _authRepository.setCurrentCountry(country);
      emit(
        state.copyWith(
          status: CountryStateStatus.loaded,
          currentCountry: country,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CountryStateStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> getCurrentAddress() async {
    try {
      emit(state.copyWith(status: CountryStateStatus.loading));
      final currentAddress = await _authRepository.getCurrentAddress();
      emit(state.copyWith(
        status: CountryStateStatus.loaded,
        currentAddress: currentAddress,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: CountryStateStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> setCurrentAddress(Address address) async {
    try {
      emit(state.copyWith(status: CountryStateStatus.loading));
      await _authRepository.setCurrentAddress(address);
      emit(
        state.copyWith(
          status: CountryStateStatus.loaded,
          currentAddress: address,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CountryStateStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> getAllAddressesAndSaveCurrentAddressLocally() async {
    try {
      emit(state.copyWith(status: CountryStateStatus.loading));
      final addresses = await _addressRepo.getAddresses();
      //after getting all addresses, set the primary address as the current address
      final primaryAddress =
          addresses.firstWhereOrNull((element) => element.isPrimary);
      if (primaryAddress != null)
        await _authRepository.setCurrentAddress(primaryAddress);
      emit(state.copyWith(
        status: CountryStateStatus.primaryAddressLoaded,
        addresses: addresses,
        currentAddress: primaryAddress,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: CountryStateStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}
