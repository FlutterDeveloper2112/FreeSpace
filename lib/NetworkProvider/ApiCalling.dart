import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freespace/Model/PostModel.dart';
import 'package:freespace/Model/UserModel.dart';
import 'package:freespace/Utils/InternetCheck.dart';
import 'package:freespace/Utils/ResponseMessage.dart';
import 'package:freespace/Utils/ToastMsg.dart';
import 'package:http/http.dart';

class ApiCalling{
  String baseUrl="https://609b59ee2b549f00176e34df.mockapi.io/api";
  InternetCheck _internetCheck = new InternetCheck();
  var internetStatus;


  Future<UserListingModel> getUserList(BuildContext context) async {
    try {

      String path = "$baseUrl/users";
      Response apiResponse;
      internetStatus = await _internetCheck.checkInternet(context);
      if(internetStatus) {
        apiResponse = await get(Uri.parse(path));
        if (apiResponse.statusCode == 200 ) {
          return UserListingModel.fromJson(jsonDecode(apiResponse.body));
        }
        else {
          ToastMsg().getToastMsg(context, "Error!");
          return UserListingModel.withError("Error in API calling!");
        }
      }
      else{
        ToastMsg().getToastMsg(context, "No Internet Connection!");
      }



    }
    catch (Exception) {
      return    ToastMsg().getToastMsg(context, "Something Went Wrong");
    }
  }

  Future<PostModel> getPostList(BuildContext context,String id) async {
    try {

      String path = "$baseUrl/users/$id/posts";
      Response apiResponse;
      internetStatus = await _internetCheck.checkInternet(context);
      if(internetStatus) {
        apiResponse = await get(Uri.parse(path));
        if (apiResponse.statusCode == 200 ) {
          return PostModel.fromJson(jsonDecode(apiResponse.body));
        }
        else {
          ToastMsg().getToastMsg(context, "Error!");
          return PostModel.withError("Error in API calling!");
        }
      }
      else{
        ToastMsg().getToastMsg(context, "No Internet Connection!");
      }


    }
    catch (Exception) {
      return    ToastMsg().getToastMsg(context, "Something Went Wrong");
    }
  }

  Future<ResponseMessage> addPost(BuildContext context,String id,String title,String bodyData) async {
    try {

      String path = "$baseUrl/users/$id/posts";
      Response apiResponse;
      Map<String,String> body={
        "title": "$title",
        "body": "$bodyData"
      };
      internetStatus = await _internetCheck.checkInternet(context);
      if(internetStatus) {
        apiResponse = await post(Uri.parse(path),body: jsonEncode(body));
        if (apiResponse.body!=null) {
          ToastMsg().getToastMsg(context, "Your Post added successfully!");
          return ResponseMessage.withSuccess("Added Successfully");
        }
        else {
          ToastMsg().getToastMsg(context, "Error!");
          return  ResponseMessage.withError("Error");
        }

      }
      else{
        ToastMsg().getToastMsg(context, "No Internet Connection!");
      }

    }
    catch (Exception) {
      return    ToastMsg().getToastMsg(context, "Something Went Wrong");
    }
  }

}