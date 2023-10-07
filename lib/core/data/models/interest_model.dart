import 'dart:convert';

class InterestModel {
  final int id;
  final String name;
  final String icon;
  final bool selected;
  InterestModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.selected,
  });

  InterestModel copyWith({
    int? id,
    String? name,
    String? icon,
    bool? selected,
  }) {
    return InterestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'selected': selected,
    };
  }

  factory InterestModel.fromMap(Map<String, dynamic> map) {
    return InterestModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      icon: map['icon'] ?? '',
      selected: map['selected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InterestModel.fromJson(String source) =>
      InterestModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'InterestModel(id: $id, name: $name, icon: $icon, selected: $selected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InterestModel &&
        other.id == id &&
        other.name == name &&
        other.selected == selected &&
        other.icon == icon;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ selected.hashCode ^ icon.hashCode;
}
