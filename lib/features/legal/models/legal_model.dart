// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class defines the variables used in the [legal_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class LegalModel extends Equatable {
  const LegalModel();

  LegalModel copyWith() {
    return const LegalModel();
  }

  @override
  List<Object?> get props => [];
}
