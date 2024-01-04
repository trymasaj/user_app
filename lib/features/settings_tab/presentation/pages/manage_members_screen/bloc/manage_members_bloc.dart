import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/manage_members_screen/models/manage_members_model.dart';
import '/core/app_export.dart';
part 'manage_members_event.dart';
part 'manage_members_state.dart';

/// A bloc that manages the state of a ManageMembers according to the event that is dispatched to it.
class ManageMembersBloc extends Bloc<ManageMembersEvent, ManageMembersState> {
  ManageMembersBloc(ManageMembersState initialState) : super(initialState) {
    on<ManageMembersInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ManageMembersInitialEvent event,
    Emitter<ManageMembersState> emit,
  ) async {}
}
