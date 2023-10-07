part of 'about_us_cubit.dart';

enum AboutUsStateStatus { initial, loading, loaded, error }

extension AboutUsStateX on AboutUsState {
  bool get isInitial => status == AboutUsStateStatus.initial;
  bool get isLoading => status == AboutUsStateStatus.loading;
  bool get isLoaded => status == AboutUsStateStatus.loaded;
  bool get isError => status == AboutUsStateStatus.error;
}

@immutable
class AboutUsState {
  final Topic? aboutUsData;
  final AboutUsStateStatus status;
  final String? errorMessage;

  const AboutUsState({
    this.aboutUsData,
    this.status = AboutUsStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as AboutUsState).aboutUsData == aboutUsData &&
        other.status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      aboutUsData.hashCode ^ status.hashCode ^ errorMessage.hashCode;

  AboutUsState copyWith({
    AboutUsStateStatus? status,
    Topic? aboutUsData,
    String? errorMessage,
  }) {
    return AboutUsState(
      status: status ?? this.status,
      aboutUsData: aboutUsData ?? this.aboutUsData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
