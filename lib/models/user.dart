import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sentry/sentry.dart' as se;
import 'package:sout/Screens/bookmarks/bookmarks.dart';

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
  bool blocked, privateAcc, _islogin = false;
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

  bool get islogin => this._islogin;

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
    try {
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
              if (usr.blocked) {
                this._islogin = false;
                usr = null;
                Fluttertoast.showToast(
                  msg: 'This user is blocked',
                  backgroundColor: Colors.red,
                  timeInSecForIosWeb: 10,
                );
              } else {
                this._islogin = true;
                Fluttertoast.showToast(
                  msg: 'Welcomeeee',
                  backgroundColor: Colors.pink,
                  timeInSecForIosWeb: 10,
                );
                return usr;
              }
            } else {
              this._islogin = false;
              Fluttertoast.showToast(
                msg: 'This user is deleted',
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 10,
              );
              usr = null;
            }
          });
        } else {
          this._islogin = false;
          Fluttertoast.showToast(
            msg:
                'This user is not registered or the password or the email is wrong.',
            backgroundColor: Colors.red,
            timeInSecForIosWeb: 10,
          );
        }
      });
    } catch (e, s) {
      await se.Sentry.captureException(
        e,
        stackTrace: s,
      );
      usr = null;
      this._islogin = false;
    }
    return usr;
  }

  Future<UserModel> register(UserModel userN) async {
    print("regUs");
    print(userN.email);
    if (userN.password == userN.confirmPassword) {
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: userN.email, password: userN.password)
            .then((value) async {
          print("created");
          await _firestore
              .collection('Users')
              .doc(value.user.uid)
              .set(userN.toJson());
          Fluttertoast.showToast(
            msg: 'Created Successfully',
            backgroundColor: Colors.pink,
            timeInSecForIosWeb: 10,
          );
        });
      } catch (e, s) {
        Fluttertoast.showToast(
          msg: "Couldn't create, Please tyr again later",
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 10,
        );
        await se.Sentry.captureException(
          e,
          stackTrace: s,
        );
        return null;
      }
      return userN;
    } else {
      Fluttertoast.showToast(
        msg: 'Password and password confirm is not matched',
        backgroundColor: Colors.red,
        timeInSecForIosWeb: 10,
      );
      return null;
    }
  }

  Future resetPassword(email) async {
    print("email");
    print(email);
    try {
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((value) => Fluttertoast.showToast(
                msg: 'Password reset email has been sent',
                backgroundColor: Colors.pink,
                timeInSecForIosWeb: 10,
              ));
    } catch (e, s) {
      await se.Sentry.captureException(
        e,
        stackTrace: s,
      );
    }
  }

  Future editProfile(UserModel newUser) async {
    try {
      await _firestore
          .collection('Users')
          .doc(this.id)
          .set(newUser.toJson())
          .then((value) => Fluttertoast.showToast(
                msg: 'Profile Updated',
                backgroundColor: Colors.green,
                timeInSecForIosWeb: 10,
              ));
    } catch (e, s) {
      await se.Sentry.captureException(
        e,
        stackTrace: s,
      );
    }
  }
}
