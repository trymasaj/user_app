// ignore_for_file: must_be_immutable

part of 'cancellation_policy_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///CancellationPolicy widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class CancellationPolicyEvent extends Equatable {}

/// Event that is dispatched when the CancellationPolicy widget is first created.
class CancellationPolicyInitialEvent extends CancellationPolicyEvent {
  @override
  List<Object?> get props => [];
}
