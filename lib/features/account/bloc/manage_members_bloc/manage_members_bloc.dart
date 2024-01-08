import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/account/models/manage_members_model.dart';
import '/core/app_export.dart';
part 'manage_members_state.dart';

/// A bloc that manages the state of a ManageMembers according to the event that is dispatched to it.
class ManageMembersBloc extends BaseCubit<ManageMembersState> {
  ManageMembersBloc(ManageMembersState initialState) : super(initialState) {}

  _onInitialize() async {}
}
