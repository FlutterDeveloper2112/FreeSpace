import 'dart:convert';

import 'Post.dart';

class UserListingModel{
  List<UserList> userList;
  String error;
  UserListingModel({this.userList});

  UserListingModel.withError(String errorMessage) {
    this.error = errorMessage;
  }

 UserListingModel.fromJson(dynamic json) {
    userList = new List<UserList>();
    if (json != null) {
      json .forEach((v) {
        userList.add(new UserList.fromJson(v));
      });
    }


  }
  }


class UserList {


  String id;
  String name;
  String avatar;
  List<Post> posts;

  UserList({
    this.id,
    this.name,
    this.avatar,
    this.posts,
  });

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
  };
}


