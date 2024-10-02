import 'package:flutter/material.dart';
import 'package:postly/ui/feed_screen.dart';
import 'package:postly/ui/liked_screen.dart';
import 'package:postly/ui/saved_posts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _pages = [
    const FeedScreen(),
    const LikedScreen(),
    const Center(child: Text('Community')),
    const SavedPostsScreen(),
  ];

  final _destinations = const [
    NavigationDestination(
      selectedIcon: Icon(Icons.home, color: Color(0xFF0A66C2)),
      icon: Icon(Icons.home_outlined, color: Colors.white),
      label: 'Feed',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.favorite, color: Color(0xFF0A66C2)),
      icon: Icon(Icons.favorite_border, color: Colors.white),
      label: 'Liked',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.people, color: Color(0xFF0A66C2)),
      icon: Icon(Icons.people_outline, color: Colors.white),
      label: 'Community',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.bookmark, color: Color(0xFF0A66C2)),
      icon: Icon(Icons.bookmark_border, color: Colors.white),
      label: 'Saved',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            destinations: _destinations,
            onDestinationSelected: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
