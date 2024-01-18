// ignore_for_file: must_be_immutable

part of 'conditions_bloc.dart';

enum ConditionsStatus { initial, loading, loaded, error }

extension AboutUsStateX on ConditionsState {
  bool get isInitial => status == ConditionsStatus.initial;
  bool get isLoading => status == ConditionsStatus.loading;
  bool get isLoaded => status == ConditionsStatus.loaded;
  bool get isError => status == ConditionsStatus.error;
}

class ConditionsState extends Equatable {
  const ConditionsState({
    required this.conditions,
    required this.status,
  });
  final ConditionsStatus status;
  final List<Condition> conditions;

  @override
  List<Object?> get props => [conditions, status];
  ConditionsState copyWith(
      {List<Condition>? conditions, ConditionsStatus? status}) {
    return ConditionsState(
        status: status ?? this.status,
        conditions: conditions ?? this.conditions);
  }

  factory ConditionsState.initial() =>
      const ConditionsState(status: ConditionsStatus.initial, conditions: []);
}
