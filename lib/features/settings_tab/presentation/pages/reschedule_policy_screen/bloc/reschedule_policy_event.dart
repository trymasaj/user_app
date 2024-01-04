// ignore_for_file: must_be_immutable

part of 'reschedule_policy_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///ReschedulePolicy widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ReschedulePolicyEvent extends Equatable {}

/// Event that is dispatched when the ReschedulePolicy widget is first created.
class ReschedulePolicyInitialEvent extends ReschedulePolicyEvent {
  @override
  List<Object?> get props => [];
}
