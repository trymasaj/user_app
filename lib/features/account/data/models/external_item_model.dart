import 'dart:convert';

class ExternalItemModel {
  final String name;
  final String? description;
  final String? picture;
  final String? url;

  ExternalItemModel({
    required this.name,
    this.description,
    this.picture,
    this.url,
  });

  ExternalItemModel copyWith({
    String? name,
    String? description,
    String? picture,
    String? url,
  }) {
    return ExternalItemModel(
      name: name ?? this.name,
      description: description ?? this.description,
      picture: picture ?? this.picture,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'picture': picture,
      'url': url,
    };
  }

  factory ExternalItemModel.fromMap(Map<String, dynamic> map) {
    return ExternalItemModel(
      name: map['name'] ?? '',
      description: map['description'],
      picture: map['picture'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExternalItemModel.fromJson(String source) =>
      ExternalItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExternalItemModel(name: $name, description: $description, picture: $picture, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExternalItemModel &&
        other.name == name &&
        other.description == description &&
        other.picture == picture &&
        other.url == url;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        picture.hashCode ^
        url.hashCode;
  }
}
