// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:masaj/core/data/models/media.dart';
import 'package:masaj/core/domain/enums/media_type.dart';

class Events {
  int? cursor;
  List<Event>? events;

  Events({
    this.cursor,
    this.events,
  });

  Events copyWith({
    int? cursor,
    List<Event>? events,
  }) {
    return Events(
      cursor: cursor ?? this.cursor,
      events: events ?? this.events,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cursor': cursor,
      'events': events?.map((x) => x.toMap()).toList(),
    }..removeWhere((_, v) => v == null);
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    return Events(
      cursor: map['cursor'] != null ? map['cursor'] as int : null,
      events: map['events'] != null
          ? (map['events'] as List).map((x) => Event.fromMap(x)).toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) =>
      Events.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Events(cursor: $cursor, events: $events)';

  @override
  bool operator ==(covariant Events other) {
    if (identical(this, other)) return true;

    return other.cursor == cursor && listEquals(other.events, events);
  }

  @override
  int get hashCode => cursor.hashCode ^ events.hashCode;
}

class Event {
  final int? zoneId;
  final int? id;
  final String? zoneName;
  final String? name;
  final String? picture;
  final String? description;
  final String? content;
  final String? address;
  final String? location;
  final String? bookingBtnLabel;
  final String? bookingURL;
  final bool? vip;
  final bool? kidsAllowed;
  final MediaType? mediaType;
  final String? src;
  final List<Media>? gallery;
  final bool? isFavorite;
  final List<DateTime>? dates;
  final EventDate? eventDate;
  final String? facebook;
  final String? twitter;
  final String? youtube;
  final String? linkedin;
  final String? instagram;
  final String? snapchat;
  final String? tiktok;
  final DateTime? date;
  final List<EventAvailableDateTime>? availableDates;
  final bool? isTicketMx;
  final bool? enableCustomDate;
  final String? customDate;

  Event({
    this.zoneId,
    this.id,
    this.zoneName,
    this.name,
    this.picture,
    this.description,
    this.content,
    this.address,
    this.location,
    this.bookingBtnLabel,
    this.bookingURL,
    this.vip,
    this.kidsAllowed,
    this.mediaType,
    this.src,
    this.gallery,
    this.isFavorite,
    this.dates,
    this.eventDate,
    this.facebook,
    this.twitter,
    this.youtube,
    this.linkedin,
    this.instagram,
    this.snapchat,
    this.tiktok,
    this.date,
    this.availableDates,
    this.isTicketMx,
    this.enableCustomDate,
    this.customDate,
  });

  Event copyWith({
    int? zoneId,
    int? id,
    String? zoneName,
    String? name,
    String? picture,
    String? description,
    String? content,
    String? address,
    String? location,
    String? bookingBtnLabel,
    String? bookingURL,
    bool? vip,
    bool? kidsAllowed,
    MediaType? mediaType,
    String? src,
    List<Media>? gallery,
    bool? isFavorite,
    List<DateTime>? dates,
    EventDate? eventDate,
    String? facebook,
    String? twitter,
    String? youtube,
    String? linkedin,
    String? instagram,
    String? snapchat,
    String? tiktok,
    DateTime? date,
    List<EventAvailableDateTime>? availableDates,
    bool? isTicketMx,
    bool? enableCustomDate,
    String? customDate,
  }) {
    return Event(
      zoneId: zoneId ?? this.zoneId,
      id: id ?? this.id,
      zoneName: zoneName ?? this.zoneName,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      description: description ?? this.description,
      content: content ?? this.content,
      address: address ?? this.address,
      location: location ?? this.location,
      bookingBtnLabel: bookingBtnLabel ?? this.bookingBtnLabel,
      bookingURL: bookingURL ?? this.bookingURL,
      vip: vip ?? this.vip,
      kidsAllowed: kidsAllowed ?? this.kidsAllowed,
      mediaType: mediaType ?? this.mediaType,
      src: src ?? this.src,
      gallery: gallery ?? this.gallery,
      isFavorite: isFavorite ?? this.isFavorite,
      dates: dates ?? this.dates,
      eventDate: eventDate ?? this.eventDate,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      youtube: youtube ?? this.youtube,
      linkedin: linkedin ?? this.linkedin,
      instagram: instagram ?? this.instagram,
      snapchat: snapchat ?? this.snapchat,
      tiktok: tiktok ?? this.tiktok,
      date: date ?? this.date,
      availableDates: availableDates ?? this.availableDates,
      isTicketMx: isTicketMx ?? this.isTicketMx,
      enableCustomDate: enableCustomDate ?? this.enableCustomDate,
      customDate: customDate ?? this.customDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'zoneId': zoneId,
      'id': id,
      'zoneName': zoneName,
      'name': name,
      'picture': picture,
      'description': description,
      'content': content,
      'address': address,
      'location': location,
      'bookingBtnLabel': bookingBtnLabel,
      'bookingURL': bookingURL,
      'vip': vip,
      'kidsAllowed': kidsAllowed,
      'mediaType': mediaType?.toString(),
      'src': src,
      'gallery': gallery?.map((x) => x.toMap()).toList(),
      'isFavorite': isFavorite,
      'dates': dates?.map((x) => x.toIso8601String()).toList(),
      'eventDate': eventDate?.toMap(),
      'facebook': facebook,
      'twitter': twitter,
      'youtube': youtube,
      'linkedIn': linkedin,
      'instagram': instagram,
      'snapChat': snapchat,
      'tiktok': tiktok,
      'date': date?.toIso8601String(),
      'availableDates': availableDates?.map((x) => x.toMap()).toList(),
      'isTicketMx': isTicketMx,
      'enableCustomDate': enableCustomDate,
      'customDate': customDate,
    }..removeWhere((_, v) => v == null);
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      zoneId: map['zoneId'] != null ? map['zoneId'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
      zoneName: map['zoneName'] != null ? map['zoneName'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      picture: map['picture'] != null ? map['picture'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      bookingBtnLabel: map['bookingBtnLabel'] != null
          ? map['bookingBtnLabel'] as String
          : null,
      bookingURL:
          map['bookingURL'] != null ? map['bookingURL'] as String : null,
      vip: map['vip'] != null ? map['vip'] as bool : null,
      kidsAllowed:
          map['kidsAllowed'] != null ? map['kidsAllowed'] as bool : null,
      mediaType: map['mediaType'] != null
          ? MediaType.values[map['mediaType'] - 1]
          : null,
      src: map['src'] != null ? map['src'] as String : null,
      gallery: map['gallery'] != null
          ? List<Media>.from(map['gallery'].map((x) => Media.fromMap(x)))
          : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
      dates: map['dates'] != null
          ? List<DateTime>.from(map['dates'].map((x) => DateTime.parse(x)))
          : null,
      eventDate:
          map['eventDate'] != null ? EventDate.fromMap(map['eventDate']) : null,
      facebook: map['facebook'] != null ? map['facebook'] as String : null,
      twitter: map['twitter'] != null ? map['twitter'] as String : null,
      youtube: map['youtube'] != null ? map['youtube'] as String : null,
      linkedin: map['linkedin'] != null ? map['linkedin'] as String : null,
      instagram: map['instagram'] != null ? map['instagram'] as String : null,
      snapchat: map['snapchat'] != null ? map['snapchat'] as String : null,
      tiktok: map['tiktok'] != null ? map['tiktok'] as String : null,
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      availableDates: map['availableDates'] != null
          ? List<EventAvailableDateTime>.from(map['availableDates']
              .map((x) => EventAvailableDateTime.fromMap(x)))
          : null,
      isTicketMx: map['isTicketMx'] != null ? map['isTicketMx'] as bool : null,
      enableCustomDate: map['enableCustomDate'] != null
          ? map['enableCustomDate'] as bool
          : null,
      customDate:
          map['customDate'] != null ? map['customDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(zoneId: $zoneId, id: $id, zoneName: $zoneName, name: $name, picture: $picture, description: $description, content: $content, address: $address, location: $location, bookingBtnLabel: $bookingBtnLabel, bookingURL: $bookingURL, vip: $vip, kidsAllowed: $kidsAllowed, mediaType: $mediaType, src: $src, gallery: $gallery, isFavorite: $isFavorite, dates: $dates, eventDate: $eventDate, facebook: $facebook, twitter: $twitter, youtube: $youtube, linkedin: $linkedin, instagram: $instagram, snapchat: $snapchat, tiktok: $tiktok, sections: , date: $date, availableDates: $availableDates, sponsors: , isTicketMx: $isTicketMx, enableCustomDate: $enableCustomDate, customDate: $customDate )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.zoneId == zoneId &&
        other.id == id &&
        other.zoneName == zoneName &&
        other.name == name &&
        other.picture == picture &&
        other.description == description &&
        other.content == content &&
        other.address == address &&
        other.location == location &&
        other.bookingBtnLabel == bookingBtnLabel &&
        other.bookingURL == bookingURL &&
        other.vip == vip &&
        other.kidsAllowed == kidsAllowed &&
        other.mediaType == mediaType &&
        other.src == src &&
        listEquals(other.gallery, gallery) &&
        other.isFavorite == isFavorite &&
        listEquals(other.dates, dates) &&
        other.eventDate == eventDate &&
        other.facebook == facebook &&
        other.twitter == twitter &&
        other.youtube == youtube &&
        other.linkedin == linkedin &&
        other.instagram == instagram &&
        other.snapchat == snapchat &&
        other.tiktok == tiktok &&
        other.date == date &&
        listEquals(other.availableDates, availableDates) &&
        other.isTicketMx == isTicketMx &&
        other.enableCustomDate == enableCustomDate &&
        other.customDate == customDate;
  }

  @override
  int get hashCode {
    return zoneId.hashCode ^
        id.hashCode ^
        zoneName.hashCode ^
        name.hashCode ^
        picture.hashCode ^
        description.hashCode ^
        content.hashCode ^
        address.hashCode ^
        location.hashCode ^
        bookingBtnLabel.hashCode ^
        bookingURL.hashCode ^
        vip.hashCode ^
        kidsAllowed.hashCode ^
        mediaType.hashCode ^
        src.hashCode ^
        gallery.hashCode ^
        isFavorite.hashCode ^
        dates.hashCode ^
        eventDate.hashCode ^
        facebook.hashCode ^
        twitter.hashCode ^
        youtube.hashCode ^
        linkedin.hashCode ^
        instagram.hashCode ^
        snapchat.hashCode ^
        tiktok.hashCode ^
        date.hashCode ^
        availableDates.hashCode ^
        isTicketMx.hashCode ^
        enableCustomDate.hashCode ^
        customDate.hashCode;
  }
}

class EventDate {
  final String startDate;
  final String endDate;
  final String? startTime;
  final String? endTime;
  final String? startDateMonth;
  final String? startDateDay;
  final String? endDateMonth;
  final String? endDateDay;

  EventDate({
    required this.startDate,
    required this.endDate,
    this.startTime,
    this.endTime,
    this.startDateMonth,
    this.startDateDay,
    this.endDateMonth,
    this.endDateDay,
  });

  EventDate copyWith({
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
    String? startDateMonth,
    String? startDateDay,
    String? endDateMonth,
    String? endDateDay,
  }) {
    return EventDate(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startDateMonth: startDateMonth ?? this.startDateMonth,
      startDateDay: startDateDay ?? this.startDateDay,
      endDateMonth: endDateMonth ?? this.endDateMonth,
      endDateDay: endDateDay ?? this.endDateDay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'startDateMonth': startDateMonth,
      'startDateDay': startDateDay,
      'endDateMonth': endDateMonth,
      'endDateDay': endDateDay,
    }..removeWhere((_, v) => v == null);
  }

  factory EventDate.fromMap(Map<String, dynamic> map) {
    return EventDate(
      startDate: map['startDate'] as String,
      endDate: map['endDate'] as String,
      startTime: map['startTime'],
      endTime: map['endTime'],
      startDateMonth: map['startDateMonth'],
      startDateDay: map['startDateDay'],
      endDateMonth: map['endDateMonth'],
      endDateDay: map['endDateDay'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventDate.fromJson(String source) =>
      EventDate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventDate(startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, startDateMonth: $startDateMonth, startDateDay: $startDateDay, endDateMonth: $endDateMonth, endDateDay: $endDateDay)';
  }

  @override
  bool operator ==(covariant EventDate other) {
    if (identical(this, other)) return true;

    return other.startDate == startDate &&
        other.endDate == endDate &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.startDateMonth == startDateMonth &&
        other.startDateDay == startDateDay &&
        other.endDateMonth == endDateMonth &&
        other.endDateDay == endDateDay;
  }

  @override
  int get hashCode {
    return startDate.hashCode ^
        endDate.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        startDateMonth.hashCode ^
        startDateDay.hashCode ^
        endDateMonth.hashCode ^
        endDateDay.hashCode;
  }
}

class EventAvailableDateTime {
  final DateTime date;
  final List<StartEndTime> times;

  EventAvailableDateTime({
    required this.date,
    required this.times,
  });

  EventAvailableDateTime copyWith({
    DateTime? date,
    List<StartEndTime>? times,
  }) {
    return EventAvailableDateTime(
      date: date ?? this.date,
      times: times ?? this.times,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.toIso8601String(),
      'times': times.map((x) => x.toMap()).toList(),
    };
  }

  factory EventAvailableDateTime.fromMap(Map<String, dynamic> map) {
    return EventAvailableDateTime(
      date: DateTime.parse(map['date']),
      times: List<StartEndTime>.from(
        (map['times']).map<StartEndTime>(
          (x) => StartEndTime.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventAvailableDateTime.fromJson(String source) =>
      EventAvailableDateTime.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EventAvailableDateTime(date: $date, times: $times)';

  @override
  bool operator ==(covariant EventAvailableDateTime other) {
    if (identical(this, other)) return true;

    return other.date == date && listEquals(other.times, times);
  }

  @override
  int get hashCode => date.hashCode ^ times.hashCode;
}

class StartEndTime {
  final DateTime startTime;
  final DateTime endTime;

  StartEndTime({
    required this.startTime,
    required this.endTime,
  });

  StartEndTime copyWith({
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return StartEndTime(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  factory StartEndTime.fromMap(Map<String, dynamic> map) {
    return StartEndTime(
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory StartEndTime.fromJson(String source) =>
      StartEndTime.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StartEndTime(startTime: $startTime, endTime: $endTime)';

  @override
  bool operator ==(covariant StartEndTime other) {
    if (identical(this, other)) return true;

    return other.startTime == startTime && other.endTime == endTime;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode;
}
