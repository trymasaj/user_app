part of 'auth_cubit.dart';

enum AuthStateStatus {
  initial,
  loading,
  interestsLoaded,
  projectsLoaded,
  loggedIn,
  signUpIn,
  guest,
  error,
  selectingProject,
  completeSignUp,
}

enum AccountStateStatus {
  initial,
  loading,
  changePhone,
  changePassword,
  verifyingChangePhone,
  error,
}

extension AuthStateX on AuthState {
  bool get isInitial => status == AuthStateStatus.initial;

  bool get isLoading => status == AuthStateStatus.loading;
  bool get isSignUpIn => status == AuthStateStatus.signUpIn;

  bool get isInterestsLoaded => status == AuthStateStatus.interestsLoaded;

  bool get isProjectsLoaded => status == AuthStateStatus.projectsLoaded;

  bool get isLoggedIn => status == AuthStateStatus.loggedIn;

  bool get isGuest => status == AuthStateStatus.guest;

  bool get isError => status == AuthStateStatus.error;
  bool get isChangePassword => status == AccountStateStatus.changePassword;
  bool get isAccountError => accountStatus == AccountStateStatus.error;

  bool get isSelectingProject => status == AuthStateStatus.selectingProject;

  bool get isCompleteSignUp => status == AuthStateStatus.completeSignUp;

  bool get isChangePhone => accountStatus == AccountStateStatus.changePhone;
  bool get isVerifyingChangePhone =>
      accountStatus == AccountStateStatus.verifyingChangePhone;
}

@immutable
class AuthState {
  final AuthStateStatus status;
  final AccountStateStatus accountStatus;
  final User? user;
  final Gender? selectedGender;
  final String? errorMessage;
  final DateTime? beginResendTimer;

  const AuthState({
    this.status = AuthStateStatus.initial,
    this.accountStatus = AccountStateStatus.initial,
    this.user,
    this.selectedGender,
    this.errorMessage,
    this.beginResendTimer,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as AuthState).status == status &&
        other.accountStatus == accountStatus &&
        other.user == user &&
        other.selectedGender == selectedGender &&
        other.beginResendTimer == beginResendTimer &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      accountStatus.hashCode ^
      user.hashCode ^
      selectedGender.hashCode ^
      errorMessage.hashCode ^
      beginResendTimer.hashCode;
  AuthState copyWith({
    AuthStateStatus? status,
    AccountStateStatus? accountStatus,
    User? user,
    String? errorMessage,
    List<InterestModel>? interests,
    List<int?>? selectedInterests,
    Gender? selectedGender,
    DateTime? beginResendTimer,
  }) {
    return AuthState(
      status: status ?? this.status,
      accountStatus: accountStatus ?? this.accountStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedGender: selectedGender ?? this.selectedGender,
      beginResendTimer: beginResendTimer ?? this.beginResendTimer,
    );
  }
}
