// ignore_for_file: must_be_immutable

part of 'terms_and_condititons_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///TermsAndCondititons widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class TermsAndCondititonsEvent extends Equatable {}

/// Event that is dispatched when the TermsAndCondititons widget is first created.
class TermsAndCondititonsInitialEvent extends TermsAndCondititonsEvent {
  @override
  List<Object?> get props => [];
}
