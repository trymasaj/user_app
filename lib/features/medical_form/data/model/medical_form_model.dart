import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:masaj/features/medical_form/data/model/condition_model.dart';

class MedicalForm {
  int? id;
  int? customerId;
  DateTime? birthDate;
  String? allergiesStatement;
  String? medicationsStatement;
  String? treatmentGoals;
  String? avoidedAreas;
  String? instructions;
  String? guardianName;
  List<MedicalCondition>? conditions;
  MedicalForm({
    this.id,
    this.customerId,
    this.birthDate,
    this.allergiesStatement,
    this.medicationsStatement,
    this.treatmentGoals,
    this.avoidedAreas,
    this.instructions,
    this.guardianName,
    this.conditions,
  });

  MedicalForm copyWith({
    ValueGetter<int?>? id,
    ValueGetter<int?>? customerId,
    ValueGetter<DateTime?>? birthDate,
    ValueGetter<String?>? allergiesStatement,
    ValueGetter<String?>? medicationsStatement,
    ValueGetter<String?>? treatmentGoals,
    ValueGetter<String?>? avoidedAreas,
    ValueGetter<String?>? instructions,
    ValueGetter<String?>? guardianName,
    ValueGetter<List<MedicalCondition>?>? conditions,
  }) {
    return MedicalForm(
      id: id != null ? id() : this.id,
      customerId: customerId != null ? customerId() : this.customerId,
      birthDate: birthDate != null ? birthDate() : this.birthDate,
      allergiesStatement: allergiesStatement != null
          ? allergiesStatement()
          : this.allergiesStatement,
      medicationsStatement: medicationsStatement != null
          ? medicationsStatement()
          : this.medicationsStatement,
      treatmentGoals:
          treatmentGoals != null ? treatmentGoals() : this.treatmentGoals,
      avoidedAreas: avoidedAreas != null ? avoidedAreas() : this.avoidedAreas,
      instructions: instructions != null ? instructions() : this.instructions,
      guardianName: guardianName != null ? guardianName() : this.guardianName,
      conditions: conditions != null ? conditions() : this.conditions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'birthDate': birthDate?.toUtc().toIso8601String(),
      'allergiesStatement': allergiesStatement,
      'medicationsStatement': medicationsStatement,
      'treatmentGoals': treatmentGoals,
      'avoidedAreas': avoidedAreas,
      'instructions': instructions,
      'guardianName': guardianName,
      'conditions': conditions?.map((x) => x.toMap()).toList(),
    };
  }

  factory MedicalForm.fromMap(Map<String, dynamic> map) {
    return MedicalForm(
      id: map['id']?.toInt(),
      customerId: map['customerId']?.toInt(),
      birthDate:
          map['birthDate'] != null ? DateTime.parse(map['birthDate']) : null,
      allergiesStatement: map['allergiesStatement'],
      medicationsStatement: map['medicationsStatement'],
      treatmentGoals: map['treatmentGoals'],
      avoidedAreas: map['avoidedAreas'],
      instructions: map['instructions'],
      guardianName: map['guardianName'],
      conditions: map['conditions'] != null
          ? List<MedicalCondition>.from(
              map['conditions']?.map((x) => MedicalCondition.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalForm.fromJson(String source) =>
      MedicalForm.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MedicalForm(id: $id, customerId: $customerId, birthDate: $birthDate, allergiesStatement: $allergiesStatement, medicationsStatement: $medicationsStatement, treatmentGoals: $treatmentGoals, avoidedAreas: $avoidedAreas, instructions: $instructions, guardianName: $guardianName, conditions: $conditions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MedicalForm &&
        other.id == id &&
        other.customerId == customerId &&
        other.birthDate == birthDate &&
        other.allergiesStatement == allergiesStatement &&
        other.medicationsStatement == medicationsStatement &&
        other.treatmentGoals == treatmentGoals &&
        other.avoidedAreas == avoidedAreas &&
        other.instructions == instructions &&
        other.guardianName == guardianName &&
        listEquals(other.conditions, conditions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        birthDate.hashCode ^
        allergiesStatement.hashCode ^
        medicationsStatement.hashCode ^
        treatmentGoals.hashCode ^
        avoidedAreas.hashCode ^
        instructions.hashCode ^
        guardianName.hashCode ^
        conditions.hashCode;
  }
}
