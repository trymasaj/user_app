// ignore_for_file: must_be_immutable

part of 'manage_members_bloc.dart';

/// Represents the state of ManageMembers in the application.
class ManageMembersState extends Equatable {
  ManageMembersState({this.manageMembersModelObj});

  ManageMembersModel? manageMembersModelObj;

  @override
  List<Object?> get props => [
        manageMembersModelObj,
      ];
  ManageMembersState copyWith({ManageMembersModel? manageMembersModelObj}) {
    return ManageMembersState(
      manageMembersModelObj:
          manageMembersModelObj ?? this.manageMembersModelObj,
    );
  }
}
