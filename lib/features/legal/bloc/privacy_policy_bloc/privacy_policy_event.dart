// ignore_for_file: must_be_immutable


import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Abstract class for all events that can be dispatched from the
///PrivacyPolicy widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class PrivacyPolicyEvent extends Equatable {}

/// Event that is dispatched when the PrivacyPolicy widget is first created.
class PrivacyPolicyInitialEvent extends PrivacyPolicyEvent {
  @override
  List<Object?> get props => [];
}
