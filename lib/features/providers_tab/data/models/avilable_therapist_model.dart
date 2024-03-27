import 'package:masaj/features/providers_tab/data/models/therapist.dart';

class AvailableTherapistModel {
  final Therapist? therapist;
  final bool? userTriedBefore;
  final List<AvailableTimeSlot>? availableTimeSlots;

  AvailableTherapistModel(
      {required this.therapist,
      required this.userTriedBefore,
      required this.availableTimeSlots});
  // from map
  factory AvailableTherapistModel.fromMap(Map<String, dynamic> map) {
    return AvailableTherapistModel(
      therapist: Therapist.fromMap(map['therapist']),
      userTriedBefore: map['userTriedBefore'],
      availableTimeSlots: map['availableTimeSlots'] == null
          ? []
          : List<AvailableTimeSlot>.from(map['availableTimeSlots']
              .map((x) => AvailableTimeSlot(timeString: x))),
    );
  }
}

class AvailableTimeSlot {
  final String? timeString;

  AvailableTimeSlot({required this.timeString});
}
