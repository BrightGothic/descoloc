import 'package:descoloc/screens/authenticate/register.dart';
import 'package:descoloc/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';

import 'graphism_update/new_page_register.dart';
import 'graphism_update/new_page_signin.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignInPageGraphism(toggleView : toggleView);//return SignIn(toggleView : toggleView);
    }else {
      return RegisterGraphics(toggleView: toggleView);
    }
  }
}
