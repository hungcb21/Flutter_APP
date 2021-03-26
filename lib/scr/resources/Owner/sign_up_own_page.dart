import 'package:flutter/material.dart';
import 'package:flutter_app/scr/blocs/sign_up_bloc.dart';
import 'package:flutter_app/scr/resources/Owner/bloc_login_own/sign_up_own_bloc.dart';
import 'package:flutter_app/scr/resources/Owner/login_own_page.dart';
import 'package:flutter_app/scr/resources/dialog/msg_dialog.dart';
import 'package:flutter_app/scr/resources/dialog/loading_dialog.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/login_page.dart';
class SignUpOwn extends StatefulWidget {
  @override
  _SignUpOwnState createState() => _SignUpOwnState();
}

class _SignUpOwnState extends State<SignUpOwn> {

  SignUpOwnBloc bloc = new SignUpOwnBloc();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:    InkWell(
          onTap: ()  {
         Navigator.pop(context);
          },
          child: Container(
            child: Image.asset("images/left-arrow2.png"),
          ),
        ),
      ),
      body: Center(
          child: Container(
            // decoration: BoxDecoration(
            //     gradient:LinearGradient(
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         colors: [
            //           Color(0xFF73AEF5),
            //           Color(0xFF61A4F1),
            //           Color(0xFF478DE0),
            //           Color(0xFF398AE5),
            //         ],
            //         stops: [0.1,0.4,0.7,0.9]
            //     )
            // ),
            color:Color(0xFF383443) ,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 90, 0, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 170,
                                  height: 157,
                                  child: new Image.asset("images/undraw_sign_in_e6hj (1) 1.png"),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Image.asset("images/Welcome to Booking Barbershop App.png")
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text("Sign Up",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(child: new Image.asset("images/user 1.png")),
                                      Container(
                                          width: 300,
                                          child: StreamBuilder(
                                            stream: bloc.userStream,
                                            builder: (context,snapshot)=>TextField(
                                              keyboardType: TextInputType.emailAddress,
                                              style: TextStyle(fontSize: 18,color: Colors.white),
                                              controller: _userController,
                                              decoration: InputDecoration(labelText: "User name or Email",
                                                  errorText: snapshot.hasError ? snapshot.error:null,
                                                  labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(child: new Image.asset("images/padlock 1.png")),
                                    Container(
                                        width: 300,
                                        child:StreamBuilder(
                                          stream: bloc.passStream,
                                          builder: (context,snapshot)=> TextField(
                                            style: TextStyle(fontSize: 18,color: Colors.white),
                                            controller: _passController,
                                            obscureText: true,
                                            decoration: InputDecoration(labelText: "Password",
                                                errorText: snapshot.hasError ? snapshot.error:null,
                                                labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(child: Icon(Icons.assignment_ind_sharp)),
                                    Container(
                                        width: 300,
                                        child: StreamBuilder(
                                          stream: bloc.nameStream,
                                          builder: (context,snapshot)=>TextField(
                                            style: TextStyle(fontSize: 18,color: Colors.white),
                                            controller: _nameController,
                                            decoration: InputDecoration(labelText: "Name",
                                                labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(child: new Image.asset("images/call 1.png")),
                                    Container(
                                        width: 300,
                                        child: StreamBuilder(
                                          stream: bloc.phoneStream,
                                          builder: (context,snapshot)=>TextField(
                                            keyboardType: TextInputType.phone,
                                            style: TextStyle(fontSize: 18,color: Colors.white),
                                            controller: _phoneController,
                                            decoration: InputDecoration(labelText: "Your phone numbers",
                                                errorText: snapshot.hasError ? snapshot.error:null,
                                                labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                                          ),
                                        )
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: SizedBox(
                                    width: 140,
                                    height: 40,
                                    child: RaisedButton(
                                      color: Colors.indigo,
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                                      onPressed: _onSignUpClicked,
                                      child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 20),),
                                    ),
                                  ),
                                ),

                              ],
                            ) ,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    ),

    );
  }
  _onSignUpClicked(){
    var isValid =bloc.isValidInfo(_userController.text, _passController.text, _phoneController.text,_nameController.text);
    if(isValid)
    {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      bloc.signUp(_userController.text, _passController.text, _phoneController.text,_nameController.text ,(){
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginOwn()));
      },(msg){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign Up", msg);
      });
    }
  }
}

