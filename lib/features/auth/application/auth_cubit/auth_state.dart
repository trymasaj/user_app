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

extension AuthStateX on AuthState {
  bool get isInitial => status == AuthStateStatus.initial;

  bool get isLoading => status == AuthStateStatus.loading;
  bool get isSignUpIn => status == AuthStateStatus.signUpIn;

  bool get isInterestsLoaded => status == AuthStateStatus.interestsLoaded;

  bool get isProjectsLoaded => status == AuthStateStatus.projectsLoaded;

  bool get isLoggedIn => status == AuthStateStatus.loggedIn;

  bool get isGuest => status == AuthStateStatus.guest;

  bool get isError => status == AuthStateStatus.error;

  bool get isSelectingProject => status == AuthStateStatus.selectingProject;

  bool get isCompleteSignUp => status == AuthStateStatus.completeSignUp;
}

@immutable
class AuthState {
  final AuthStateStatus status;
  final User? user;
  final Gender? selectedGender;
  final String? errorMessage;
  final DateTime? beginResendTimer;

  const AuthState({
    this.status = AuthStateStatus.initial,
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
        other.user == user &&
        other.selectedGender == selectedGender &&
        other.beginResendTimer == beginResendTimer &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      user.hashCode ^
      selectedGender.hashCode ^
      errorMessage.hashCode ^
      beginResendTimer.hashCode;
  AuthState copyWith({
    AuthStateStatus? status,
    User? user,
    String? errorMessage,
    List<InterestModel>? interests,
    List<int?>? selectedInterests,
    Gender? selectedGender,
    DateTime? beginResendTimer,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedGender: selectedGender ?? this.selectedGender,
      beginResendTimer: beginResendTimer ?? this.beginResendTimer,
    );
  }
}
