

class Event {
  final EventLocation eventLocation;
  final String id;
  final User user;
  final String description;
  final String title;
  final List<String> images;
  final List<String> likedUsers;
  final List<String> comments;
  final List<String> eventCategory;
  final String eventStartAt;
  final String eventEndAt;
  final bool registrationRequired;
  final List<String> keywords;
  final List<String> hashTags;
  final List<String> registration;
  final int likes;
  final String createdAt;
  final String updatedAt;
  final int v;

  Event({
    required this.eventLocation,
    required this.id,
    required this.user,
    required this.description,
    required this.title,
    required this.images,
    required this.likedUsers,
    required this.comments,
    required this.eventCategory,
    required this.eventStartAt,
    required this.eventEndAt,
    required this.registrationRequired,
    required this.keywords,
    required this.hashTags,
    required this.registration,
    required this.likes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventLocation: EventLocation.fromJson(json['eventLocation']),
      id: json['_id'],
      user: User.fromJson(json['user']),
      description: json['description'],
      title: json['title'],
      images: List<String>.from(json['images']),
      likedUsers: List<String>.from(json['likedUsers']),
      comments: List<String>.from(json['comments']),
      eventCategory: List<String>.from(json['eventCategory']),
      eventStartAt: json['eventStartAt'],
      eventEndAt: json['eventEndAt'],
      registrationRequired: json['registrationRequired'],
      keywords: List<String>.from(json['keywords']),
      hashTags: List<String>.from(json['hashTags']),
      registration: List<String>.from(json['registration']),
      likes: json['likes'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventLocation': eventLocation.toJson(),
      '_id': id,
      'user': user.toJson(),
      'description': description,
      'title': title,
      'images': images,
      'likedUsers': likedUsers,
      'comments': comments,
      'eventCategory': eventCategory,
      'eventStartAt': eventStartAt,
      'eventEndAt': eventEndAt,
      'registrationRequired': registrationRequired,
      'keywords': keywords,
      'hashTags': hashTags,
      'registration': registration,
      'likes': likes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class EventLocation {
  final List<double> coordinates;

  EventLocation({required this.coordinates});

  factory EventLocation.fromJson(Map<String, dynamic> json) {
    return EventLocation(
      coordinates: List<double>.from(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coordinates': coordinates,
    };
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final bool isVerified;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      isVerified: json['isVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'isVerified': isVerified,
    };
  }
}