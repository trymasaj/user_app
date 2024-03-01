part of 'members_cubit.dart';

enum MembersStateStatus { initial, loading, loaded, error }

extension MembersStateX on MembersState {
  bool get isInitial => status == MembersStateStatus.initial;
  bool get isLoading => status == MembersStateStatus.loading;
  bool get isLoaded => status == MembersStateStatus.loaded;
  bool get isError => status == MembersStateStatus.error;
}

class MembersState {
  final MembersStateStatus status;
  final List<MemberModel>? members;
  final MemberModel? selectedMember;
  final String? errorMessage;

  const MembersState({
    this.members,
    this.selectedMember,
    this.status = MembersStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as MembersState).status == status &&
        other.members == members &&
        other.selectedMember == selectedMember &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      errorMessage.hashCode ^
      Object.hashAll(members ?? []) ^
      selectedMember.hashCode;

  MembersState copyWith(
      {MembersStateStatus? status,
      String? errorMessage,
      MemberModel? selectedMember,
      List<MemberModel>? members}) {
    return MembersState(
      status: status ?? this.status,
      members: members ?? this.members,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedMember: selectedMember ?? this.selectedMember,
    );
  }
}
