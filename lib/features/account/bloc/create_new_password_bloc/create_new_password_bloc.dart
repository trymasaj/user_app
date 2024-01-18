import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';

part 'create_new_password_state.dart';

/// A bloc that manages the state of a CreateNewPasswordOne according to the event that is dispatched to it.
class CreateNewPasswordOneBloc extends BaseCubit<CreateNewPasswordState> {
  CreateNewPasswordOneBloc(super.initialState);

  void _onInitialize() async {}
}
