import 'package:flutter/material.dart';
import 'package:sout/blocs/blocs.dart';
import 'package:sout/models/models.dart';
import '../service_locator.dart';


class Login extends StatefulWidget {
  final String title = 'Sign In';

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold();
  }
}

// Example code of how to sign in with email and password.
// void _signInWithEmailAndPassword() async {
//   if (!_formKey.currentState.validate()) {
//     return;
//   }
//   setState(() {
//     loading = true;
//   });
//   try {
//     final User user = (await _auth.signInWithEmailAndPassword(
//       email: _emailController.text,
//       password: _passwordController.text,
//     )).user;
//     setState(() {
//       loading = false;
//     });
//     Scaffold.of(context).showSnackBar(SnackBar(
//       content: Text("${user.email} signed in"),
//     ));
//     Navigator.of(context).pushNamed(PageRouteName.CAMERA);
//   } catch (e) {
//     setState(() {
//       loading = false;
//     });
//     Scaffold.of(context).showSnackBar(SnackBar(
//       content: Text("Failed to sign in with Email & Password"),
//     ));
//   }
// }
