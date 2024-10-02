import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';
import '../services/api_service.dart';

final postProvider = StateNotifierProvider<PostNotifier, List<Post>>((ref) {
  return PostNotifier();
});

class PostNotifier extends StateNotifier<List<Post>> {
  PostNotifier() : super([]);
  int currentPage = 1;
  bool isLoading = false;
  final ApiService apiService = ApiService();

  Future<void> fetchPosts({String? query}) async {
    if (!isLoading) {
      isLoading = true;
      final newPosts = await apiService.fetchPosts(currentPage,query: query);
      debugPrint('Fetched ${newPosts.length} posts');
      state = [...state, ...newPosts];
      currentPage++;
      isLoading = false;
    }
  }

  void likePost(int postId) {
    state = [
      for (final post in state)
        if (post.id == postId) post.copyWith(likes: post.likes + 1) else post,
    ];
  }

  List<Post> getLikedPosts() {
    return state.where((post) => post.likes > 0).toList();
  }

  Post getPostById(int postId) {
    return state.firstWhere((post) => post.id == postId);
  }
}
