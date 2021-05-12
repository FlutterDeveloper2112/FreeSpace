
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freespace/Bloc/UserBloc.dart';
import 'package:freespace/Utils/AppBarWidget.dart';
import 'package:freespace/Utils/ToastMsg.dart';


class AddPostUi extends StatefulWidget{
  String id;
  AddPostUi(this.id);

  AddPostUiState createState()=> new AddPostUiState();

}
class AddPostUiState extends State<AddPostUi>{
  TextEditingController postTitleController = TextEditingController();
  TextEditingController postBodyController = TextEditingController();
  UserBloc bloc= new UserBloc();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child:MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
              appBar: AppBarWidget().getAppbar("Add Post", context),
              body: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(

                    controller: postTitleController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusColor: Colors.black,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green, width: 0.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.green, width: 0.0),
                      ),

                      labelText: 'Post Title',
                      labelStyle: TextStyle(color:Colors.green)


                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    maxLines: 5,
                    controller: postBodyController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusColor: Colors.black,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green, width: 0.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green, width: 0.0),
                        ),

                        labelText: 'Post Body',
                        labelStyle: TextStyle(color:Colors.green)


                    ),
                  ),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  child: Text('ADD POST',style: TextStyle(color: Colors.black),),
                  onPressed: (){
                    if(postBodyController.text.length>0 && postTitleController.text.length>0){
                        bloc.addPostBloc(widget.id,postTitleController.text.trim(),postBodyController.text.trim());
                        bloc.addPostList.listen((event) {
                          print(event.success);
                          event.success!=null?Navigator.of(context).pop():null;

                        });
                    }
                    else{
                      ToastMsg().getToastMsg(context, "Please enter the fields");
                    }
                  },
                )
              ],
            )
        )
    ),
          ),
        );



  }

}