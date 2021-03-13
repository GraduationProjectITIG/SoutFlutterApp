import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:sout/blocs/userbloc.dart';
import 'package:sout/models/user.dart';
import '../exetensions/exetnsion.dart';
import '../utils/utils.dart';
import 'login.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'signup.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  final String title = 'Registration';

  @override
  State<StatefulWidget> createState() => _SignupState();
}

enum SingingCharacter { female, male }

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String _genderController = "";
  String _birtdayController = "";

  bool _success, loading = false;
  UserBloc _userBloc = UserBloc();
  UserModel newUser = UserModel();
  String _userEmail;
  SingingCharacter _character = SingingCharacter.female;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.pink, //(0xff7267f3),
        elevation: 0,
      ),
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.pink, Colors.white],
        )),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2)),
                validator: (String value) {
                  if (value.length < 2) {
                    return "Please enter valid name";
                  }
                  return null;
                },
              ).addStyleOnly(mediaQuery),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2)),
                validator: (String value) {
                  if (value.length < 2) {
                    return "Please enter valid name";
                  }
                  return null;
                },
              ).addStyleOnly(mediaQuery),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2)),
                validator: (String value) {
                  if (!Validator.isEmail(value)) {
                    print(_emailController.text);
                    // _userEmail = value;
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ).addStyleOnly(mediaQuery),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2)),
                validator: (String value) {
                  if (value.length < 6) {
                    return "Password can't be less than 6 characters";
                  }
                  return null;
                },
                obscureText: true,
              ).addStyleOnly(mediaQuery),
              TextFormField(
                controller: _passwordConfirmController,
                decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2)),
                validator: (String value) {
                  if (value.length < 6) {
                    return "Password can't be less than 6 characters";
                  }
                  return null;
                },
                obscureText: true,
              ).addStyleOnly(mediaQuery),
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(
                    labelText: 'Mobile',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2)),
                validator: (String value) {
                  if (double.tryParse(value) == null) {
                    return "Mobile must be number";
                  }
                  return null;
                },
              ).addStyleOnly(mediaQuery),
              Column(children: <Widget>[
                Text("Gender"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<SingingCharacter>(
                      value: SingingCharacter.female,
                      groupValue: _character,
                      onChanged: (SingingCharacter val) {
                        setState(() {
                          _character = val;
                          _genderController = "female";
                        });
                      },
                    ),
                    Text("Female"),
                    Radio<SingingCharacter>(
                      value: SingingCharacter.male,
                      groupValue: _character,
                      onChanged: (SingingCharacter val) {
                        setState(() {
                          _character = val;
                          _genderController = "male";
                        });
                      },
                    ),
                    Text("Male"),
                  ],
                ),
              ]),
              FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1800, 1, 1),
                        maxTime: DateTime(2021, 12, 30), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      _birtdayController = "$date";
                      print('confirm $_birtdayController');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Text(
                    'Choose birthday',
                    style: TextStyle(color: Colors.pink),
                  )),
              SizedBox(
                height: mediaQuery.size.height * 0.02,
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      'Register',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.pink, fontWeight: FontWeight.bold),
                    ).addSocialStyleOnly(mediaQuery, _register),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _register() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    // setState(() {
    //   loading = true;
    // });

    _userBloc.register(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _passwordController.text,
        _passwordConfirmController.text,
        _mobileController.text,
        _genderController,
        _birtdayController);
  }
}
