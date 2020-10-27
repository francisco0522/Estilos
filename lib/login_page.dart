import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'first_screen.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool _success;
String _userEmail;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

    @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signinEmail(),
              _signInButton(),
            ],
        ),
      ),
    );
  }

  _signinEmail() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0,  bottom: 80.0),
    child: Column(
      children: <Widget>[
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Contraseña'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
        margin: const EdgeInsets.only(left: 50.0, top: 20.0),
          child: RaisedButton(
            color: Color.fromRGBO(20, 120, 200, 1),
            onPressed: () async {
                _login();
            },
            child: const Text('Ingresar'),
          ),
        ),

        Container(
        
        margin: const EdgeInsets.only(top: 20.0),
          child: RaisedButton(
            color: Color.fromRGBO(100, 200, 250, 1),
            onPressed: () async {

                _register();

            },
            child: const Text('Registrarse'),
          ),
        ),
        Container(
          child: Text(_success == null
              ? ''
              : (_success
                  ? 'Successfully registered ' + _userEmail
                  : 'Registration failed')),
        )

      ])
        
      ],
    ));
  }

  _register() async {
    try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
  }

  _login() async{
    try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
_state();
  }

  _state(){
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                },
              ),
            );

    }
  });
  }



  _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Ingresar con Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
