import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/utils/db_helper.dart';

class SavedPostNotifier extends StateNotifier<List<int>> {
  SavedPostNotifier() : super([]);

  void loadSavedPosts() async {
    List<int> savedPostIds = await DBHelper.fetchSavedPostIds();
    state = [...state, ...savedPostIds];
  }

  void savePost(int postId) {
    state = [...state, postId];
    DBHelper.savePostId(postId);
  }
}

final savedPostProvider =
    StateNotifierProvider<SavedPostNotifier, List<int>>((ref) {
  return SavedPostNotifier();
});
