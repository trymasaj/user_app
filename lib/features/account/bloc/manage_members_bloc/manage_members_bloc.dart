import 'package:equatable/equatable.dart';
<<<<<<< HEAD
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/account/models/manage_members_model.dart';

=======
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/account/models/manage_members_model.dart';
>>>>>>> origin/moatasem
part 'manage_members_state.dart';

/// A bloc that manages the state of a ManageMembers according to the event that is dispatched to it.
class ManageMembersBloc extends BaseCubit<ManageMembersState> {
  ManageMembersBloc(super.initialState);

  _onInitialize() async {}
}
