class ReviewModel {
  int? id;
  int? rating;
  String? customerOpinion;
  String? improveServicesHint;
  DateTime? reviewDate;
  bool? isPublished;
  int? sortKey;
  int? bookingId;
  int? therapistId;
  int? customerId;
  // bookingReview": {
  //   "id": 5,
  //   "rating": 3,
  //   "customerOpinion": "",
  //   "improveServicesHint": "",
  //   "reviewDate": "0001-01-01T00:00:00",
  //   "isPublished": false,
  //   "sortKey": 0,
  //   "bookingId": 70,
  //   "therapistId": 133,
  //   "customerId": 93,
  //   "tiPaymentRequest": null
  // }
  TiPaymentRequest? tiPaymentRequest;

  ReviewModel({
    this.id,
    this.rating,
    this.customerOpinion,
    this.improveServicesHint,
    this.reviewDate,
    this.isPublished,
    this.sortKey,
    this.bookingId,
    this.therapistId,
    this.customerId,
    this.tiPaymentRequest,
  });
  // copy with method
  ReviewModel copyWith({
    int? id,
    int? rating,
    String? customerOpinion,
    String? improveServicesHint,
    DateTime? reviewDate,
    bool? isPublished,
    int? sortKey,
    int? bookingId,
    int? therapistId,
    int? customerId,
    TiPaymentRequest? tiPaymentRequest,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      customerOpinion: customerOpinion ?? this.customerOpinion,
      improveServicesHint: improveServicesHint ?? this.improveServicesHint,
      reviewDate: reviewDate ?? this.reviewDate,
      isPublished: isPublished ?? this.isPublished,
      sortKey: sortKey ?? this.sortKey,
      bookingId: bookingId ?? this.bookingId,
      therapistId: therapistId ?? this.therapistId,
      customerId: customerId ?? this.customerId,
      tiPaymentRequest: tiPaymentRequest ?? this.tiPaymentRequest,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating': rating,
      'customerOpinion': customerOpinion,
      'improveServicesHint': improveServicesHint,
      'reviewDate': reviewDate?.millisecondsSinceEpoch,
      'isPublished': isPublished,
      'sortKey': sortKey,
      'bookingId': bookingId,
      'therapistId': therapistId,
      'customerId': customerId,
      'tiPaymentRequest': tiPaymentRequest?.toMap(),
    }..removeWhere((_, v) => v == null);
  }

  // fromMap method
  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id']?.toInt() ?? 0,
      rating: map['rating']?.toInt(),
      customerOpinion: map['customerOpinion'],
      improveServicesHint: map['improveServicesHint'],
      reviewDate:
          map['reviewDate'] != null ? DateTime.parse(map['reviewDate']) : null,
      isPublished: map['isPublished'],
      sortKey: map['sortKey']?.toInt(),
      bookingId: map['bookingId']?.toInt(),
      therapistId: map['therapistId']?.toInt(),
      customerId: map['customerId']?.toInt(),
      tiPaymentRequest: map['tiPaymentRequest'] != null
          ? TiPaymentRequest.fromMap(map['tiPaymentRequest'])
          : null,
    );
  }

  @override
  String toString() {
    return 'ReviewResponse(id: $id, rating: $rating, customerOpinion: $customerOpinion, improveServicesHint: $improveServicesHint, reviewDate: $reviewDate, isPublished: $isPublished, sortKey: $sortKey, bookingId: $bookingId, therapistId: $therapistId, customerId: $customerId, tiPaymentRequest: $tiPaymentRequest)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewModel &&
        other.id == id &&
        other.rating == rating &&
        other.customerOpinion == customerOpinion &&
        other.improveServicesHint == improveServicesHint &&
        other.reviewDate == reviewDate &&
        other.isPublished == isPublished &&
        other.sortKey == sortKey &&
        other.bookingId == bookingId &&
        other.therapistId == therapistId &&
        other.customerId == customerId &&
        other.tiPaymentRequest == tiPaymentRequest;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rating.hashCode ^
        customerOpinion.hashCode ^
        improveServicesHint.hashCode ^
        reviewDate.hashCode ^
        isPublished.hashCode ^
        sortKey.hashCode ^
        bookingId.hashCode ^
        therapistId.hashCode ^
        customerId.hashCode ^
        tiPaymentRequest.hashCode;
  }
}

class TiPaymentRequest {
  int? id;
  DateTime? createdAt;
  String? chargeId;
  String? idempotencyKey;
  DateTime? idempotencyKeyExpiry;
  int? paymentMethod;
  int? type;
  int? status;
  String? errorMessage;
  DateTime? completionDate;
  bool? isThreeDSecure;
  String? threeDSecureUrl;
  int? amount;
  int? countryId;

  TiPaymentRequest({
    this.id,
    this.createdAt,
    this.chargeId,
    this.idempotencyKey,
    this.idempotencyKeyExpiry,
    this.paymentMethod,
    this.type,
    this.status,
    this.errorMessage,
    this.completionDate,
    this.isThreeDSecure,
    this.threeDSecureUrl,
    this.amount,
    this.countryId,
  });
  // copy with method
  TiPaymentRequest copyWith({
    int? id,
    DateTime? createdAt,
    String? chargeId,
    String? idempotencyKey,
    DateTime? idempotencyKeyExpiry,
    int? paymentMethod,
    int? type,
    int? status,
    String? errorMessage,
    DateTime? completionDate,
    bool? isThreeDSecure,
    String? threeDSecureUrl,
    int? amount,
    int? countryId,
  }) {
    return TiPaymentRequest(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      chargeId: chargeId ?? this.chargeId,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      idempotencyKeyExpiry: idempotencyKeyExpiry ?? this.idempotencyKeyExpiry,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      type: type ?? this.type,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      completionDate: completionDate ?? this.completionDate,
      isThreeDSecure: isThreeDSecure ?? this.isThreeDSecure,
      threeDSecureUrl: threeDSecureUrl ?? this.threeDSecureUrl,
      amount: amount ?? this.amount,
      countryId: countryId ?? this.countryId,
    );
  }

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'chargeId': chargeId,
      'idempotencyKey': idempotencyKey,
      'idempotencyKeyExpiry': idempotencyKeyExpiry?.millisecondsSinceEpoch,
      'paymentMethod': paymentMethod,
      'type': type,
      'status': status,
      'errorMessage': errorMessage,
      'completionDate': completionDate?.millisecondsSinceEpoch,
      'isThreeDSecure': isThreeDSecure,
      'threeDSecureUrl': threeDSecureUrl,
      'amount': amount,
      'countryId': countryId,
    }..removeWhere((_, v) => v == null);
  }

  // fromMap method
  factory TiPaymentRequest.fromMap(Map<String, dynamic> map) {
    return TiPaymentRequest(
      id: map['id']?.toInt() ?? 0,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : null,
      chargeId: map['chargeId'],
      idempotencyKey: map['idempotencyKey'],
      idempotencyKeyExpiry: map['idempotencyKeyExpiry'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['idempotencyKeyExpiry'])
          : null,
      paymentMethod: map['paymentMethod']?.toInt(),
      type: map['type']?.toInt(),
      status: map['status']?.toInt(),
      errorMessage: map['errorMessage'],
      completionDate: map['completionDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['completionDate'])
          : null,
      isThreeDSecure: map['isThreeDSecure'],
      threeDSecureUrl: map['threeDSecureUrl'],
      amount: map['amount']?.toInt(),
      countryId: map['countryId']?.toInt(),
    );
  }

  @override
  String toString() {
    return 'TiPaymentRequest(id: $id, createdAt: $createdAt, chargeId: $chargeId, idempotencyKey: $idempotencyKey, idempotencyKeyExpiry: $idempotencyKeyExpiry, paymentMethod: $paymentMethod, type: $type, status: $status, errorMessage: $errorMessage, completionDate: $completionDate, isThreeDSecure: $isThreeDSecure, threeDSecureUrl: $threeDSecureUrl, amount: $amount, countryId: $countryId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TiPaymentRequest &&
        other.id == id &&
        other.createdAt == createdAt &&
        other.chargeId == chargeId &&
        other.idempotencyKey == idempotencyKey &&
        other.idempotencyKeyExpiry == idempotencyKeyExpiry &&
        other.paymentMethod == paymentMethod &&
        other.type == type &&
        other.status == status &&
        other.errorMessage == errorMessage &&
        other.completionDate == completionDate &&
        other.isThreeDSecure == isThreeDSecure &&
        other.threeDSecureUrl == threeDSecureUrl &&
        other.amount == amount &&
        other.countryId == countryId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        chargeId.hashCode ^
        idempotencyKey.hashCode ^
        idempotencyKeyExpiry.hashCode ^
        paymentMethod.hashCode ^
        type.hashCode ^
        status.hashCode ^
        errorMessage.hashCode ^
        completionDate.hashCode ^
        isThreeDSecure.hashCode ^
        threeDSecureUrl.hashCode ^
        amount.hashCode ^
        countryId.hashCode;
  }
}
