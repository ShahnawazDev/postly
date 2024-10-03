import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:postly/models/event.dart';
import 'package:postly/utils/db_helper.dart';
import 'dart:convert';
import '../models/post.dart';

class ApiService {
  static const String baseUrl = 'https://evika.onrender.com';
  static const String eventsUrl = '$baseUrl/api/event';
  static const String searchUrl = '$baseUrl/search';

  Future<List<Post>> fetchPosts(int page, {String? query}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return DBHelper.fetchPosts();
    } else {
      final List<Event> events = await fetchEvents(page, query: query);
      final List<Post> posts = events
          .map((event) => Post(
                id: event.id.hashCode,
                username: '${event.user.firstName} ${event.user.lastName}',
                content: event.images.first,
                likes: event.likes,
                comments: event.comments.length,
                description: event.description,
                category: event.eventCategory,
              ))
          .toList();

      for(var post in posts){
        await DBHelper.insertPost(post);
      }

      return posts;
    }
  }

  Future<List<Event>> fetchEvents(int page, {String? query}) async {
    try {
      final url = query != null
          ? '$searchUrl?q=$query&page=$page&limit=10'
          : '$eventsUrl?page=$page&limit=10';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> jsonEvents = jsonData['data']['events'];
        final List<Event> events =
            jsonEvents.map((event) => Event.fromJson(event)).toList();
        return events;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Error fetching events: $e');
    }
  }
}
