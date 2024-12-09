// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

/// This class defines the variables used in the [account_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class AccountModel extends Equatable {
  const AccountModel();

  AccountModel copyWith() {
    return const AccountModel();
  }

  @override
  List<Object?> get props => [];
}
