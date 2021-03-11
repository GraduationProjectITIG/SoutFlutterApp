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
      //TODO continue
      'id': id,
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      //TODO continue
      id: doc.data()["id"],
    );
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
          //TODO continue
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

  Future<List<UserModel>> getUsers() async {
    List<UserModel> list = [];
    //TODO add firestore method
    return list;
  }
}
