import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id,firstName,lastName, email,password,confirmPassword,favColor,favMode,mobile,gender,picURL,coverPicURL,birthDate;
  bool blocked,privateAcc,islogin = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel({this.id,this.firstName,this.lastName, this.email,this.password,this.confirmPassword,this.favColor,this.favMode,this.mobile,this.gender,this.picURL,this.coverPicURL,this.birthDate,this.blocked,this.privateAcc}) {}

  // Future<UserModel> login(email, password) async {
  //   UserModel usr = UserModel();
  //   await _auth
  //       .signInWithEmailAndPassword(email: email, password: password)
  //       .then((value) {
  //         //TODO add user values.
  //       });
  //   return usr;
  // }

  // Future<List<UserModel>> getUsers() async {
  //   List<UserModel> list = [];
  //   //TODO add firestore method
  //   return list;
  // }

}
