import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/post.dart';

class DBHelper {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'posts.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE posts(id INTEGER PRIMARY KEY, username TEXT, content TEXT, likes INTEGER, comments INTEGER, description TEXT, category TEXT)",
        );
        db.execute(
          "CREATE TABLE saved_posts(id INTEGER PRIMARY KEY)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertPost(Post post) async {
    final db = await DBHelper.database();
    await db.insert(
      'posts',
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Post>> fetchPosts() async {
    final db = await DBHelper.database();
    final List<Map<String, dynamic>> maps = await db.query('posts');
    return List.generate(maps.length, (i) {
      return Post(
        id: maps[i]['id'],
        username: maps[i]['username'],
        content: maps[i]['content'],
        likes: maps[i]['likes'],
        comments: maps[i]['comments'],
        description: maps[i]['description'],
        category: List<String>.from(json.decode(maps[i]['category'])),
      );
    });
  }

  // New method to save post ID
  static Future<void> savePostId(int id) async {
    try {
      final db = await DBHelper.database();
      await db.insert(
        'saved_posts',
        {'id': id},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint('Post ID saved successfully');
    } catch (e) {
      debugPrint('Error saving post ID: $e');
    }
  }

  // New method to fetch saved post IDs
  static Future<List<int>> fetchSavedPostIds() async {
    try {
      final db = await DBHelper.database();
      final List<Map<String, dynamic>> maps = await db.query('saved_posts');
        debugPrint('Fetched saved post IDs successfully');
      return List.generate(maps.length, (i) {
        return maps[i]['id'];
      });
    
    } catch (e) {
      debugPrint('Error fetching saved post IDs: $e');
      return [];
    }
  }
}