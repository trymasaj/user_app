part of 'auth_cubit.dart';

enum AuthStateStatus {
  initial,
  loading,
  interestsLoaded,
  projectsLoaded,
  loggedIn,
  guest,
  error,
  selectingProject,
}

extension AuthStateX on AuthState {
  bool get isInitial => status == AuthStateStatus.initial;

  bool get isLoading => status == AuthStateStatus.loading;

  bool get isInterestsLoaded => status == AuthStateStatus.interestsLoaded;

  bool get isProjectsLoaded => status == AuthStateStatus.projectsLoaded;

  bool get isLoggedIn => status == AuthStateStatus.loggedIn;

  bool get isGuest => status == AuthStateStatus.guest;

  bool get isError => status == AuthStateStatus.error;

  bool get isSelectingProject => status == AuthStateStatus.selectingProject;
}

@immutable
class AuthState {
  final AuthStateStatus status;
  final User? user;
  final Gender? selectedGender;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStateStatus.initial,
    this.user,
    this.selectedGender,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as AuthState).status == status &&
        other.user == user &&
        other.selectedGender == selectedGender &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      user.hashCode ^
      selectedGender.hashCode ^
      errorMessage.hashCode;

  AuthState copyWith({
    AuthStateStatus? status,
    User? user,
    String? errorMessage,
    List<InterestModel>? interests,
    List<int?>? selectedInterests,
    Gender? selectedGender,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }
}
