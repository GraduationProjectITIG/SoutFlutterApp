import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sout/blocs/blocs.dart';
import 'package:sout/models/models.dart';
import 'package:sout/utils/page_route_name.dart';
import 'package:sout/utils/validator.dart';
import '../service_locator.dart';
import '../exetensions/exetnsion.dart';
import 'bookmarks/bookmarks.dart';
import 'signup.dart';
import '../blocs/userbloc.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  final String title = 'Sign In';

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'SOUT';

    // return Scaffold();
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: Center(
            child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyCustomForm(),
              ]),
        )),

        // Center(child:
        // Container(
        //   child:Column(children
        // crossAxisAlignment: CrossAxisAlignment.start,
        // : <Widget>[
        //   MyCustomForm(),

        //   ])

        // )
        // ),

        //   floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context)=>MyPage()),
        //     );
        //   },
        //   tooltip: 'Increment',
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  UserBloc _userBloc = UserBloc();
  UserModel uss = UserModel();
  // UserBloc get user => _userBloc;
  bool loading = false;
  BuildContext dialogContext;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
        margin: EdgeInsets.all(24),
        padding: EdgeInsets.only(top: 24),
        alignment: Alignment.center,
        child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (!Validator.isEmail(value)) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  )),
              TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  )),
              Row(children: <Widget>[
                Expanded(
                  // padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      // uss = await _userBloc.login(
                      //     _emailController.text, _passwordController.text);

                      // if (sL<UserBloc>().isLogin) {
                      //   print("loginmmmm");
                      //   print(uss.firstName);
                      // }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bookmarks(logedUser: uss)));

                      // _signInWithEmailAndPassword(context);
                    },
                    child: Text('Login'),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Center(
                  child: new InkWell(
                      child: Text(
                        'Need an account? Register',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: new InkWell(
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onTap: () => {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  dialogContext = context;
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(32.0)),
                                    ),
                                    elevation: 16,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(32.0)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [Colors.pink, Colors.white],
                                          )),
                                      height: 226.0,
                                      width: 360.0,
                                      child: ListView(
                                        children: <Widget>[
                                          SizedBox(height: 20),
                                          Center(
                                            child: Text(
                                              "Forget Password",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.grey,
                                            height: 20,
                                            thickness: 1,
                                            endIndent: 0,
                                          ),
                                          TextFormField(
                                            controller: _emailController,
                                            decoration: const InputDecoration(
                                                labelText: 'Email',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.all(2)),
                                            validator: (String value) {
                                              if (!Validator.isEmail(value)) {
                                                print(_emailController.text);
                                                return 'Please enter valid email';
                                              }
                                              return null;
                                            },
                                          ).addStyleOnly(mediaQuery),
                                          InkWell(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 20.0, bottom: 20.0),
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  32.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  32.0)),
                                                ),
                                                child: Text(
                                                  "Reset",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              onTap: () => {
                                                    _userBloc.resetPassword(
                                                        _emailController.text),
                                                    Navigator.pop(dialogContext)
                                                  }),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          }),
                ),
              ),
            ])));
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
