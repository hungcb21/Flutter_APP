import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
class FierAuth{

  FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  //ham dang ky
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
  //Ham dang nhap
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
  //ham upload cua hang
  void upLoadStore(String image,String name,String address,String city,String district,String timeStart,String timeEnd,String description,Function onSuccess, )
  {
    String UID = _fireBaseAuth.currentUser.uid;
    var store ={"Image":image,"NameStore":name,"Address":address, "City":city,"District":district,"TimeStart":timeStart,"TimeEnd":timeEnd,"Description":description};
    var ref = FirebaseDatabase.instance.reference().child("Stores");
    ref.child(UID).set(store).then((store){
      onSuccess();
    });

  }
  //ham lay UID
  Future<String> getCurrentUID() async{
    return (await _fireBaseAuth.currentUser).uid;
  }
  Future getCurrentUser() async{
    return await _fireBaseAuth.currentUser;
  }

  //ham upthong tin nguoi dung dang ky ken db
  _createUser(String userID,String email,String pass,String phone,String name,Function onSuccess)
  {
    var user ={"email":email,"pass":pass, "phone":phone,"name":name};
    var ref = FirebaseDatabase.instance.reference().child("Onwners");
    ref.child(userID).set(user).then((user) {
      onSuccess();
    }).catchError((err){
      print("err: " + err.toString());
    });
  }
  //ham bat loi dang ky sai
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
//ham dang xuat
  Future<void> signOut() async {
    print("signOut");
    return _fireBaseAuth.signOut();
  }

}
