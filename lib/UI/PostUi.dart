
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freespace/Bloc/UserBloc.dart';
import 'package:freespace/Utils/AppBarWidget.dart';
import 'AddPostUi.dart';
import '../Model/PostModel.dart';


class PostUi extends StatefulWidget{
  String id;
  PostUi(this.id);

  PostUiState createState()=> new PostUiState();

}
class PostUiState extends State<PostUi> {
  final bloc = UserBloc();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await bloc.fetchPostList(widget.id);
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
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            resizeToAvoidBottomInset: false,

            appBar: AppBarWidget().getAppbar("POST", context),
            body: RefreshIndicator(
              onRefresh: refreshData,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(

                  children: [
                    StreamBuilder(
                      stream: bloc.postList,
                      builder: (context, AsyncSnapshot<PostModel> snapshot) {
                        if (snapshot.hasData) {
                          if(snapshot.data!=null && snapshot.data.postList.length>0){

                            return Padding(
                              padding: EdgeInsets.all(30),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.postList.length,
                                  itemBuilder: (BuilderContext, index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      elevation: 10,
                                      child: Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20,
                                              right: 20,
                                              top: 20,
                                              bottom: 30),
                                          child: Column(

                                            children: [
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("Post Title",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black))),
                                              SizedBox(height: 5,),
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("${snapshot.data
                                                      .postList[index].title},")),
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text("${snapshot.data
                                                      .postList[index].body},")),

                                            ],
                                          ),
                                        ),
                                      ),


                                    );
                                  }),
                            );
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                var result = Navigator.push(
                    context, MaterialPageRoute(builder: (BuildContext context) {
                  return AddPostUi(widget.id);
                }));
                // ignore: unrelated_type_equality_checks
                result == true ? refreshData() : null;
              },
              backgroundColor: Colors.black,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
        )
    );
  }

  Future<void> refreshData() async {
    if (mounted) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        bloc.fetchPostList(widget.id);
      });
    }
  }
}