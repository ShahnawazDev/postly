import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/ui/widgets/custom_app_bar.dart';
import 'package:postly/utils/assets_path.dart';
import '../providers/post_provider.dart';
import 'widgets/post_tile.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<FeedScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref.read(postProvider.notifier).fetchPosts();
      }
    });
    ref.read(postProvider.notifier).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFE3E1DE),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Container(
            height: 66,
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              children: [
                Flexible(
                  child: SearchBar(
                    controller: _searchController,
                    elevation: const WidgetStatePropertyAll(0),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.only(left: 16),
                    ),
                    backgroundColor:
                        const WidgetStatePropertyAll(Color(0xFFEBF2FA)),
                    leading: const Icon(Icons.search),
                    hintText: "Search mesaages",
                    onChanged: (value) {
                      // ref.read(postProvider.notifier).fetchPosts(query: value);
                    },
                  ),
                ),
                IconButton(
                  icon: Image.asset(AssetsPath.filterIcon),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index < posts.length) {
                  return PostTile(post: posts[index]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
