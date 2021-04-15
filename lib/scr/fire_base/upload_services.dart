import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UpServicesToFir{
  FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void uploadServices(String nameServices,double price,String description,String image,Function onSuccess){
    String uid = _fireBaseAuth.currentUser.uid;
    var services={"NameServices":nameServices,"Price":price,"Description":description,"Image":image};
    var ref = FirebaseDatabase.instance.reference().child("Stores");
    ref.child(uid).child("Services").push().set(services).then((store){
      onSuccess();
    });
  }
}