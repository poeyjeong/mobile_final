// To parse this JSON data, do
//
//     final postdetails = postdetailsFromJson(jsonString);

import 'dart:convert';

Postdetails postdetailsFromJson(String str) => Postdetails.fromJson(json.decode(str));

String postdetailsToJson(Postdetails data) => json.encode(data.toJson());

class Postdetails {
    List<Post>? posts;

    Postdetails({
        this.posts,
    });

    factory Postdetails.fromJson(Map<String, dynamic> json) => Postdetails(
        posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
    };
}

class Post {
    String? id;
    String? author;
    String? title;
    int? likes;
    int? dislikes;
    List<Comment>? comments;
    List<Post>? posts;

    Post({
        this.id,
        this.author,
        this.title,
        this.likes,
        this.dislikes,
        this.comments,
        this.posts,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        author: json["author"],
        title: json["title"],
        likes: json["likes"],
        dislikes: json["dislikes"],
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
        posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "title": title,
        "likes": likes,
        "dislikes": dislikes,
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
    };
}

class Comment {
    String? author;
    String? content;

    Comment({
        this.author,
        this.content,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        author: json["author"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "author": author,
        "content": content,
    };
}
