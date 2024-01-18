import 'dart:convert';

class Topic {
  final String name;
  final String? content;
  final String? picture;

  Topic({
    required this.name,
    required this.content,
    this.picture,
  });

  Topic copyWith({
    String? name,
    String? content,
    String? picture,
  }) {
    return Topic(
      name: name ?? this.name,
      content: content ?? this.content,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'content': content,
      'picture': picture,
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      name: map['name'] ?? '',
      content: map['content'],
      picture: map['picture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) => Topic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Topic( name: $name, content: $content, picture: $picture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Topic &&
        other.name == name &&
        other.content == content &&
        other.picture == picture;
  }

  @override
  int get hashCode {
    return name.hashCode ^ content.hashCode ^ picture.hashCode;
  }
}
