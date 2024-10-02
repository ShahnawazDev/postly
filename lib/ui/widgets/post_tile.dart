import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/providers/saved_post_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:postly/providers/post_provider.dart';
import 'package:postly/utils/assets_path.dart';
import '../../models/post.dart';

class PostTile extends ConsumerWidget {
  final Post post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(post.username),
            subtitle: Text(post.username.split(' ').first),
            trailing: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextButton.icon(
                              onPressed: () => {
                                ref
                                    .read(savedPostProvider.notifier)
                                    .savePost(post.id)
                              },
                              icon: const Icon(Icons.bookmark_add),
                              label: const Text('Save'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: Stack(
              children: [
                Image.network(post.content),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.63),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text('Live', style: TextStyle(color: Colors.white)),
                        ],
                      )),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: post.description.split(' ').take(7).join(' '),
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xFF1F1F1F)),
                  ),
                  TextSpan(
                    text:
                        ' ${post.description.split(' ').skip(7).take(5).join(' ')}', // Adjust the split logic as needed
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xFF1F1F1F)),
                  ),
                  const TextSpan(
                    text: '... ',
                    style: TextStyle(fontSize: 16, color: Color(0xFF1F1F1F)),
                  ),
                  const TextSpan(
                    text: 'see more',
                    style: TextStyle(fontSize: 16, color: Color(0xFF99A2AD)),
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    ref.read(postProvider.notifier).likePost(post.id);
                  },
                  icon: Image.asset(AssetsPath.likeIcon),
                  label: Text(
                    '${post.likes}K Likes',
                    style: const TextStyle(
                      color: Color(0xFF99A2AD),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Image.asset(AssetsPath.commentsIcon),
                  label: Text(
                    "${post.comments} Comments",
                    style: const TextStyle(
                      color: Color(0xFF99A2AD),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Share.share(post.description);
                  },
                  icon: Image.asset(AssetsPath.shareIcon),
                  label: const Text(
                    'Share',
                    style: TextStyle(
                      color: Color(0xFF99A2AD),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
