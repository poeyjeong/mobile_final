// post_model.dart
import 'dart:convert';

// To parse JSON data into a list of Post objects
List<Post> postsFromJson(String str) {
  final jsonData = utf8.decode(str.codeUnits);
  final jsonMap = jsonDecode(jsonData);
  return List<Post>.from(jsonMap.map((x) => Post.fromJson(x)));
}

// To serialize a list of Post objects into JSON format
String postsToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  String id;
  String author;
  String title;
  int likes;
  int dislikes;
  List<Comment> comments;

  Post({
    required this.id,
    required this.author,
    required this.title,
    required this.likes,
    required this.dislikes,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    author: json["author"],
    title: json["title"],
    likes: json["likes"],
    dislikes: json["dislikes"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "title": title,
    "likes": likes,
    "dislikes": dislikes,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  String author;
  String content;
  String? postId;

  Comment({
    required this.author,
    required this.content,
    this.postId, required String ,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    author: json["author"],
    content: json["content"],
    postId: json["postId"], String: null,
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "content": content,
    "postId": postId,
  };
}
