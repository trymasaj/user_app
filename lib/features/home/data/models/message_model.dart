enum MessageReadType { All, Read, Unread }

class MessagesModel {
  int? id;
  int? messageCategoryId;
  String? categoryKey;
  String? title;
  String? body;
  Map<String, String>? additionalData;
  DateTime? expiryDate;
  DateTime? deleteDate;
  bool? seen;
  DateTime? seenDate;

  MessagesModel({
    this.id,
    this.messageCategoryId,
    this.categoryKey,
    this.title,
    this.body,
    this.additionalData,
    this.expiryDate,
    this.deleteDate,
    this.seen,
    this.seenDate,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      id: json['id'],
      messageCategoryId: json['messageCategoryId'],
      categoryKey: json['categoryKey'],
      title: json['title'],
      body: json['body'],
      additionalData: json['additionalData'] != null
          ? Map<String, String>.from(json['additionalData'])
          : null,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : null,
      deleteDate: json['deleteDate'] != null
          ? DateTime.parse(json['deleteDate'])
          : null,
      seen: json['seen'],
      seenDate: json['seenDate'] != null
          ? DateTime.parse(json['seenDate'])
          : null,
    );
  }
  @override
  String toString() {
    return 'MessagesModel(id: $id, messageCategoryId: $messageCategoryId, categoryKey: $categoryKey, title: $title, body: $body, additionalData: $additionalData, expiryDate: $expiryDate, deleteDate: $deleteDate, seen: $seen, seenDate: $seenDate)';
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MessagesModel &&
      other.id == id &&
      other.messageCategoryId == messageCategoryId &&
      other.categoryKey == categoryKey &&
      other.title == title &&
      other.body == body &&
      other.additionalData == additionalData &&
      other.expiryDate == expiryDate &&
      other.deleteDate == deleteDate &&
      other.seen == seen &&
      other.seenDate == seenDate;
  }
  @override
  int get hashCode {
    return id.hashCode ^
      messageCategoryId.hashCode ^
      categoryKey.hashCode ^
      title.hashCode ^
      body.hashCode ^
      additionalData.hashCode ^
      expiryDate.hashCode ^
      deleteDate.hashCode ^
      seen.hashCode ^
      seenDate.hashCode;
  }

  // copyWith method
  MessagesModel copyWith({
    int? id,
    int? messageCategoryId,
    String
    ? categoryKey,  
    String  
    ? title,  
    String  
    ? body,
    Map<String, String>
    ? additionalData,
    DateTime
    ? expiryDate,
    DateTime
    ? deleteDate,
    bool
    ? seen,
    DateTime
    ? seenDate,
  }) {
    return MessagesModel(
      id: id ?? this.id,
      messageCategoryId: messageCategoryId ?? this.messageCategoryId,
      categoryKey: categoryKey ?? this.categoryKey,
      title: title ?? this.title,
      body: body ?? this.body,
      additionalData: additionalData ?? this.additionalData,
      expiryDate: expiryDate ?? this.expiryDate,
      deleteDate: deleteDate ?? this.deleteDate,
      seen: seen ?? this.seen,
      seenDate: seenDate ?? this.seenDate,
    );
  }
  
}