import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/providers/post_provider.dart';
import 'package:postly/providers/saved_post_provider.dart';
import 'package:postly/ui/widgets/post_tile.dart';

class SavedPostsScreen extends ConsumerWidget {
  const SavedPostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedPostIds = ref.watch(savedPostProvider);
    final postProviderNotifier = ref.watch(postProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Posts'),
        centerTitle: true,
      ),
      body: savedPostIds.isEmpty
          ? const Center(
              child: Text('No Saved Post'),
            )
          : ListView.builder(
              itemCount: savedPostIds.length,
              itemBuilder: (context, index) {
                final postId = savedPostIds[index];
                final post = postProviderNotifier.getPostById(postId);

                return PostTile(post: post);
              },
            ),
    );
  }
}
