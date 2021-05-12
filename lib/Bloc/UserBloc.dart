import 'dart:async';

import 'package:freespace/Model/PostModel.dart';
import 'package:freespace/Model/UserModel.dart';
import 'package:freespace/Repo/UserRepo.dart';
import 'package:freespace/Utils/ResponseMessage.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc{

  var _userListFetcher = new  StreamController<UserListingModel>();
  var _userPostListFetcher = new  StreamController<PostModel>();
  var _addPostListFetcher = new  StreamController<ResponseMessage>();



  Stream<UserListingModel> get userList => _userListFetcher.stream;
  Stream<PostModel> get postList => _userPostListFetcher.stream;
  Stream<ResponseMessage> get addPostList => _addPostListFetcher.stream;



  fetchUserList() async {
    UserListingModel model= await UserRepo().getUserList();
    _userListFetcher.sink.add(model);
  }

  fetchPostList(String id) async {
    PostModel model= await UserRepo().getPostList(id);
    _userPostListFetcher.sink.add(model);
  }

  addPostBloc(String id, String title,String body) async{
    ResponseMessage model= await UserRepo().addPost(id,title,body);
    _addPostListFetcher.sink.add(model);
  }



  void dispose(){
    _userListFetcher.close();
    _userPostListFetcher.close();
    _addPostListFetcher.close();
  }
}
