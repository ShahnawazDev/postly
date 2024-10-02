import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/post.dart';

class DBHelper {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'posts.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE posts(id INTEGER PRIMARY KEY, username TEXT, content TEXT, likes INTEGER, comments INTEGER, description TEXT)",
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
        category: maps[i]['category'],// may need to change this due to category habing list of strings
      );
    });
  }
}
