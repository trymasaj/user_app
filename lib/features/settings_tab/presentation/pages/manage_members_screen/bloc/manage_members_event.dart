// ignore_for_file: must_be_immutable

part of 'manage_members_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ManageMembers widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ManageMembersEvent extends Equatable {}

/// Event that is dispatched when the ManageMembers widget is first created.
class ManageMembersInitialEvent extends ManageMembersEvent {
  @override
  List<Object?> get props => [];
}
