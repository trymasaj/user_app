import 'package:masaj/features/providers_tab/data/models/therapist.dart';
import 'package:masaj/features/services/data/models/service_model.dart';

class HomeSearchResponse {
  final List<Therapist>? therapists;
  final List<ServiceModel>? services;
static HomeSearchResponse empty = HomeSearchResponse(therapists: [], services: []);
  HomeSearchResponse({
    required this.therapists,
    required this.services,
  });

  HomeSearchResponse copyWith({
    List<Therapist>? therapists,
    List<ServiceModel>? services,
  }) {
    return HomeSearchResponse(
      therapists: therapists ?? this.therapists,
      services: services ?? this.services,
    );
  }

  // mape
  Map<String, dynamic> toMap() {
    return {
      'therapists': therapists?.map((x) => x.toMap()).toList(),
      'services': services?.map((x) => x.toMap()).toList(),
    };
  }

  // fromMap
  factory HomeSearchResponse.fromMap(Map<String, dynamic> map) {
    return HomeSearchResponse(
      therapists: map['therapists'] == null
          ? []
          : List<Therapist>.from(
              map['therapists']?.map((x) => Therapist.fromMap(x))),
      services: map['services'] == null
          ? []
          : List<ServiceModel>.from(
              map['services']?.map((x) => ServiceModel.fromMap(x))),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSearchResponse &&
        other.therapists == therapists &&
        other.services == services;
  }

  @override
  int get hashCode => therapists.hashCode ^ services.hashCode;

  @override
  String toString() =>
      'HomeSearchResponse(therapists: $therapists, services: $services)';
}
