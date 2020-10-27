import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sign_in.dart';

class FirstScreen extends StatelessWidget {


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

            ],
        ),
      ),
    );
  }
}