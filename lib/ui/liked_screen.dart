import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/ui/widgets/post_tile.dart';
import '../providers/post_provider.dart';

class LikedScreen extends ConsumerWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedPosts =
        ref.watch(postProvider).where((post) => post.likes > 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Posts'),
        centerTitle: true,
      ),
      body: likedPosts.isNotEmpty
          ? ListView.builder(
              itemCount: likedPosts.length,
              itemBuilder: (context, index) {
                final post = likedPosts[index];
                return PostTile(post: post);
              },
            )
          : const Center(
              child: Text('No liked posts'),
            ),
    );
  }
}
