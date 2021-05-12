

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freespace/Bloc/UserBloc.dart';
import 'package:freespace/Model/UserModel.dart';
import 'package:freespace/UI/PostUi.dart';

class UserUi extends StatefulWidget{
  UserUiState createState()=> new UserUiState();

}
class UserUiState extends State<UserUi>{
  final bloc= UserBloc();

  @override
  void initState() {
    bloc.fetchUserList();
    super.initState();
  }
  @override
  void dispose() {
    bloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
        child:MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            appBar: AppBar( title:Text("Users",style: TextStyle(color: Colors.black),),toolbarHeight: 40,backgroundColor: Colors.white,),
            body:  SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  StreamBuilder<UserListingModel>(
                    stream: bloc.userList,
                    builder: (context, AsyncSnapshot<UserListingModel> snapshot) {
                      if (snapshot.hasData) {
                        if(snapshot.data!=null && snapshot.data.userList.length>0){

                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.userList.length,
                              itemBuilder: (BuilderContext,index){
                                return Padding(
                                  padding: EdgeInsets.all(15),
                                  child: InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                        return PostUi(snapshot.data.userList[index].id);
                                      }));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.account_circle_outlined,color: Colors.grey,),
                                        SizedBox(width: 15,),
                                        Text("${snapshot.data.userList[index].name}")
                                      ],

                                    ),
                                  ),
                                );

                              });
                        }
                      }
                      else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return Center(child: Padding(
                        padding:  EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(backgroundColor: Colors.green),
                      ));
                    },
                  ),

                ],
              ),
            ),
          ),
        )
    );


  }

}