import 'dart:convert';

import 'package:freespace/Model/Post.dart';

class PostModel{
  List<Post> postList;
  String error;
  PostModel({this.postList});

  PostModel.withError(String errorMessage) {
    this.error = errorMessage;
  }

  PostModel.fromJson(dynamic json) {
    postList = new List<Post>();
    if (json != null) {
      json .forEach((v) {
        postList.add(new Post.fromJson(v));
      });
    }


  }
}
