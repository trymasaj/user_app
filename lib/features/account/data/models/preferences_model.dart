import 'dart:convert';

class Preferences {
  final int id;
  final String name;
  final bool selected;

  Preferences({
    required this.id,
    required this.name,
    required this.selected,
  });

  Preferences copyWith({
    int? id,
    String? name,
    bool? selected,
  }) {
    return Preferences(
      id: id ?? this.id,
      name: name ?? this.name,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'selected': selected,
    };
  }

  factory Preferences.fromMap(Map<String, dynamic> map) {
    return Preferences(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      selected: map['selected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Preferences.fromJson(String source) =>
      Preferences.fromMap(json.decode(source));

  @override
  String toString() => 'Preferences(id: $id, name: $name, selected: $selected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Preferences &&
        other.id == id &&
        other.name == name &&
        other.selected == selected;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ selected.hashCode;
}
