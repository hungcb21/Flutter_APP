import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
class FirAuth{

    FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

    // void getUserInfo()

    void signUp(String email,String pass,String phone,String name,Function onSuccess,Function(String) onSignUpError)
    {
      _fireBaseAuth.
      createUserWithEmailAndPassword(email: email, password: pass)
          .then((user){
            _createUser(user.user.uid, email, pass, phone,name, onSuccess);
            print(user);
      }).catchError((err){
        print("err: " + err.toString());
        _onSignUpErr;
        onSignUpError("Sign-Un fail, please try again");
      });
    }
    void signIn(String email, String pass, Function onSuccess,
        Function(String) onSignInError) {
      _fireBaseAuth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((user) {
            onSuccess();
      }).catchError((err) {
        print("err: " + err.toString());
        onSignInError("Sign-In fail, please try again");
      });
    }
    Future<String> getCurrentUID() async{
      return (await _fireBaseAuth.currentUser).uid;
    }
    Future getCurrentUser() async{
      return await _fireBaseAuth.currentUser;
    }

    _createUser(String userID,String email,String pass,String phone,String name,Function onSuccess)
    {
      var user ={"email":email,"pass":pass, "phone":phone,"name":name};
      var ref = FirebaseDatabase.instance.reference().child("Users");
      ref.child(userID).set(user).then((user) {
        onSuccess();
      }).catchError((err){
        print("err: " + err.toString());
      });
    }
    void _onSignUpErr(String code, Function(String) onRegisterError) {
      print(code);
      switch (code) {
        case "ERROR_INVALID_EMAIL":
        case "ERROR_INVALID_CREDENTIAL":
          onRegisterError("Invalid email");
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          onRegisterError("Email has existed");
          break;
        case "ERROR_WEAK_PASSWORD":
          onRegisterError("The password is not strong enough");
          break;
        default:
          onRegisterError("SignUp fail, please try again");
          break;
      }
    }

    Future<void> signOut() async {
      print("signOut");
      return _fireBaseAuth.signOut();
    }

}
