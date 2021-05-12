

import 'package:flutter/material.dart';
import 'package:freespace/Model/PostModel.dart';
import 'package:freespace/Model/UserModel.dart';
import 'package:freespace/NetworkProvider/ApiCalling.dart';
import 'package:freespace/Utils/ResponseMessage.dart';
import 'package:http/http.dart';

class UserRepo{
  BuildContext context;

  

  Future<UserListingModel> getUserList() => ApiCalling().getUserList(context);
  Future<PostModel> getPostList(String id) => ApiCalling().getPostList(context,id);
  Future<ResponseMessage> addPost(String id,String title,String body) => ApiCalling().addPost(context,id,title,body);


}
