import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserModel {
  String id,
      firstName,
      lastName,
      email,
      password,
      confirmPassword,
      favColor,
      favMode,
      mobile,
      gender,
      picURL,
      coverPicURL,
      birthDate;
  bool blocked, privateAcc, islogin = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.confirmPassword,
      this.favColor,
      this.favMode,
      this.mobile,
      this.gender,
      this.picURL,
      this.coverPicURL,
      this.birthDate,
      this.blocked,
      this.privateAcc});

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "firstName": this.firstName,
      "secondName": this.lastName,
      "email": this.email,
      "favColor": this.favColor,
      "favMode": this.favMode,
      "mobile": this.mobile,
      "gender": this.gender,
      "picURL": this.picURL,
      "coverPicURL": this.coverPicURL,
      "birthDate": this.birthDate,
      "blocked": this.blocked,
      "privateAcc": this.privateAcc
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
        id: doc.data()["id"],
        firstName: doc.data()["firstName"],
        lastName: doc.data()["secondName"],
        email: doc.data()["email"],
        favColor: doc.data()["favColor"],
        favMode: doc.data()["favMode"],
        mobile: doc.data()["mobile"],
        gender: doc.data()["gender"],
        picURL: doc.data()["picURL"],
        coverPicURL: doc.data()["coverPicURL"],
        birthDate: doc.data()["birthDate"],
        blocked: doc.data()["blocked"],
        privateAcc: doc.data()["privateAcc"]);
  }

  Future<UserModel> login(email, password) async {
    UserModel usr = UserModel();
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      if (value.user.uid != null) {
        await _firestore
            .collection('Users')
            .doc(value.user.uid)
            .get()
            .then((user) {
          if (user != null) {
            usr = UserModel.fromDocument(user);
            this.islogin = true;
          } else {
            Fluttertoast.showToast(
              msg: 'This user is deleted',
              backgroundColor: Colors.red,
              timeInSecForIosWeb: 10,
            );
            usr = null;
          }
        });
      } else {
        Fluttertoast.showToast(
          msg:
              'This user is not registered or the password or the email is wrong.',
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 10,
        );
      }
    });
    return usr;
  }

  Future<UserModel> register() async {}

  Future resetPassword(email) async {}

 Future editProfile(UserModel newUser) async {}


  Future<List<UserModel>> getUsers() async {
    List<UserModel> list = [];
    //TODO add firestore method
    return list;
  }
}
