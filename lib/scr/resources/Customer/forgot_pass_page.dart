import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/blocs/sign_up_bloc.dart';
import 'package:flutter_app/scr/resources/Customer/choose_user_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/login_page.dart';

import '../dialog/loading_dialog.dart';
class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  SignUpBloc bloc = new SignUpBloc();
  TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            color:Color(0xFF383443) ,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Text("Forgot Password?",style: TextStyle(fontSize: 30,color: Colors.white),),
                ),
                Container(
                    width: 300,
                    child: StreamBuilder(
                      stream: bloc.userStream,
                      builder: (context,snapshot)=>TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 18,color: Colors.white),
                        controller: _emailController,
                        decoration: InputDecoration(labelText: "Email",
                            errorText: snapshot.hasError ? snapshot.error:null,
                            labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.indigo,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                      onPressed: _onResetPassClicked,
                      child: Text("Reset Password",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _onResetPassClicked(){
      LoadingDialog.showLoadingDialog(context, "Loading...");
      FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text).then((value){
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseUser()));
      } );

  }
}
