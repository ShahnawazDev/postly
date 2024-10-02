class Post {
  final int id;
  final String username;
  final String content;
  final int likes;
  final int comments;
  final String description;
  final List<String> category;

  Post({
    required this.id,
    required this.username,
    required this.content,
    required this.likes,
    required this.comments,
    required this.description,
    required this.category,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      username: json['username'],
      content: json['content'],
      likes: json['likes'],
      comments: json['comments'],
      description: json['description'],
      category: List<String>.from(json['category']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'content': content,
      'likes': likes,
      'comments': comments,
      'description': description,
      'category': category,
    };
  }

  Post copyWith({int? likes}) {
    return Post(
      id: id,
      username: username,
      content: content,
      likes: likes ?? this.likes,
      comments: comments,
      description: description,
      category: category,
    );
  }
}