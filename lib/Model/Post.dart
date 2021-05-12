class Post {
  Post({
    this.id,
    this.author,
    this.title,
    this.body,
  });

  String id;
  String author;
  String title;
  String body;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    author: json["author"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "author": author,
    "title": title,
    "body": body,
  };
}