import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedPostNotifier extends StateNotifier<List<int>> {
  SavedPostNotifier() : super([]);

  void savePost(int postId) {
    state = [...state, postId];
  }
}

final savedPostProvider = StateNotifierProvider<SavedPostNotifier, List<int>>((ref) {
  return SavedPostNotifier();
});