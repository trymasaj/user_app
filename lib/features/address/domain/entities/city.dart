
class Area {
  final String name;
  final int id;

  Area({required this.name, required this.id});

  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(
      name: map['name'],
      id: map['id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }
}
