// ignore_for_file: must_be_immutable

part of 'legal_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Legal widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class LegalEvent extends Equatable {}

/// Event that is dispatched when the Legal widget is first created.
class LegalInitialEvent extends LegalEvent {
  @override
  List<Object?> get props => [];
}
