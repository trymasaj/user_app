import 'package:country_pickers/country.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/core/domain/enums/gender.dart';
import 'package:masaj/features/account/models/add_member_model.dart';

part 'add_member_state.dart';

/// A bloc that manages the state of a AddMember according to the event that is dispatched to it.
class AddMemberBloc extends BaseCubit<AddMemberState> {
  AddMemberBloc(super.initialState);

  changeCountry(Country country) {
    emit(state.copyWith(selectedCountry: some(country)));
  }

  onInitialize() async {}
}
