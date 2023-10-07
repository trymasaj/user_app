import 'dart:convert';

import '../../enums/media_type.dart';

class Media {
  final String? name;
  final String src;
  final MediaType mediaType;
  Media({
    this.name,
    required this.src,
    required this.mediaType,
  });

  Media copyWith({
    String? name,
    String? src,
    MediaType? mediaType,
  }) {
    return Media(
      name: name ?? this.name,
      src: src ?? this.src,
      mediaType: mediaType ?? this.mediaType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'src': src,
      'mediaType': mediaType.id,
    }..removeWhere((_, v) => v == null);
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      name: map['name'],
      src: map['src'] as String,
      mediaType: MediaType.values[(map['mediaType'] as int) - 1],
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) =>
      Media.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Media(name: $name, src: $src, mediaType: $mediaType)';

  @override
  bool operator ==(covariant Media other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.src == src &&
        other.mediaType == mediaType;
  }

  @override
  int get hashCode => name.hashCode ^ src.hashCode ^ mediaType.hashCode;
}
