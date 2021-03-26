import 'package:flutter/material.dart';
import 'package:flutter_app/scr/blocs/login_bloc.dart';
import 'package:flutter_app/scr/resources/Customer/sign_up_page.dart';
import 'package:flutter_app/scr/resources/dialog/loading_dialog.dart';
import 'package:flutter_app/scr/resources/dialog/msg_dialog.dart';
import 'forgot_pass_page.dart';
import 'main_menu_page.dart';
class Login extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}
class _ExampleState extends State<Login> {
  LoginBloc bloc = new LoginBloc();
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading:   InkWell(
            onTap: () {Navigator.pop(context);},
            child: Container(
              child: Image.asset("images/left-arrow2.png"),
            ),
          ),
        ),
        body: Container(
            color:Color(0xFF383443) ,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 100, 0, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Image.asset("images/undraw_mobile_login_ikmv1.png"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Not a member yet ?",style: TextStyle(fontSize: 18),),
                                    new FlatButton(
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                            builder: (context)=>SignUp()
                                        )
                                        );
                                      },
                                      child: new Text("Sign Up",style: TextStyle(fontSize: 18,color: Colors.yellow),),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                                  child: Text("Login",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(child: new Image.asset("images/user 1.png")),
                                      Container(
                                        width: 300,
                                        child: StreamBuilder(
                                          stream: bloc.userStream ,
                                          builder: (context,snapshots)=>  TextField(
                                            keyboardType: TextInputType.emailAddress,
                                          style: TextStyle(fontSize: 18,color: Colors.white),
                                          controller: _userController,
                                          decoration: InputDecoration(labelText: "User name or Email",
                                              errorText: snapshots.hasError ? snapshots.error:null,
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
                                      child: StreamBuilder(
                                              stream: bloc.passStream,
                                              builder: (context, snapshot) => TextField(
                                            style: TextStyle(fontSize: 18,color: Colors.white),
                                            controller: _passController,
                                            obscureText: true,
                                            decoration: InputDecoration(labelText: "Password",
                                                errorText: snapshot.hasError ? snapshot.error : null,
                                                labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                                          ),
                                      )
                                    ),
                                  ],
                                ),
                                new FlatButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPass()));
                                  },
                                  child: new Text("Forgot password ?",style: TextStyle(fontSize: 18,color: Colors.yellow),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: SizedBox(
                                    width: 140,
                                    height: 40,
                                    child: RaisedButton(
                                      color: Colors.indigo
                                      ,
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                                      onPressed:onLoginCliked,
                                      child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text("Or",style: TextStyle(fontSize: 18,color: Colors.black),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                                  child: new Image.asset("images/facebook 1.png"),
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
          ),
      ),
    );
  }
  void onLoginCliked(){
    String email =_userController.text;
    String pass = _passController.text;
    var isValid =bloc.isValidInfo(_userController.text, _passController.text);
    if(bloc.isValidInfo(_userController.text, _passController.text))
      {
        LoadingDialog.showLoadingDialog(context, "Loading...");
        bloc.signIn(_userController.text, _passController.text, (){
          LoadingDialog.hideLoadingDialog(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        },(msg){
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, "Login", msg);
        });
      }
  }
}


