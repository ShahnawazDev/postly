
import 'package:postly/models/event.dart';

class EventResponse {
  final String message;
  final EventData data;

  EventResponse({required this.message, required this.data});

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      message: json['message'],
      data: EventData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class EventData {
  final int currentPage;
  final int totalPages;
  final List<Event> events;

  EventData(
      {required this.currentPage,
      required this.totalPages,
      required this.events});

  factory EventData.fromJson(Map<String, dynamic> json) {
    var eventsList = json['events'] as List;
    List<Event> events = eventsList.map((i) => Event.fromJson(i)).toList();

    return EventData(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      events: events,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
      'events': events.map((e) => e.toJson()).toList(),
    };
  }
}
