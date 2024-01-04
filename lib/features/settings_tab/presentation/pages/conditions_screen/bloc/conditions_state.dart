// ignore_for_file: must_be_immutable

part of 'conditions_bloc.dart';

/// Represents the state of Conditions in the application.
class ConditionsState extends Equatable {
  ConditionsState({
    this.osteoporosis = false,
    this.pregnancyCheckbox = false,
    this.thumbsup = false,
    this.chestPainCheckbox = false,
    this.varicoseVeinsCheckbox = false,
    this.neckpain = false,
    this.diabetesCheckbox = false,
    this.conditionsModelObj,
  });

  ConditionsModel? conditionsModelObj;

  bool osteoporosis;

  bool pregnancyCheckbox;

  bool thumbsup;

  bool chestPainCheckbox;

  bool varicoseVeinsCheckbox;

  bool neckpain;

  bool diabetesCheckbox;

  @override
  List<Object?> get props => [
        osteoporosis,
        pregnancyCheckbox,
        thumbsup,
        chestPainCheckbox,
        varicoseVeinsCheckbox,
        neckpain,
        diabetesCheckbox,
        conditionsModelObj,
      ];
  ConditionsState copyWith({
    bool? osteoporosis,
    bool? pregnancyCheckbox,
    bool? thumbsup,
    bool? chestPainCheckbox,
    bool? varicoseVeinsCheckbox,
    bool? neckpain,
    bool? diabetesCheckbox,
    ConditionsModel? conditionsModelObj,
  }) {
    return ConditionsState(
      osteoporosis: osteoporosis ?? this.osteoporosis,
      pregnancyCheckbox: pregnancyCheckbox ?? this.pregnancyCheckbox,
      thumbsup: thumbsup ?? this.thumbsup,
      chestPainCheckbox: chestPainCheckbox ?? this.chestPainCheckbox,
      varicoseVeinsCheckbox:
          varicoseVeinsCheckbox ?? this.varicoseVeinsCheckbox,
      neckpain: neckpain ?? this.neckpain,
      diabetesCheckbox: diabetesCheckbox ?? this.diabetesCheckbox,
      conditionsModelObj: conditionsModelObj ?? this.conditionsModelObj,
    );
  }
}
