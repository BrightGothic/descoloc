///This class is the gate of the app.
///The builder checks if there is a user connected.
///If so, it shows the inside of the app, personnalized for each user
///If not, it shows the Signin page (screens/authenticate/signin.dart


import 'package:descoloc/models/user.dart';
import 'package:descoloc/screens/authenticate/graphism_update/new_page_forgotten_password.dart';
import 'package:descoloc/screens/home/homepage.dart';
import 'package:descoloc/screens/authenticate/authenticate.dart';
import 'package:descoloc/screens/colocschoice/coloc_choice.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserInApp?>(context);

    //return either Home or Authenticate widget
    if (user == null) {// Check if the user exists.
      return Authenticate();                   // If not, displays the Authenticate pages
    }else{
      if (ManipulateSharedPreferences().getalreadyVisited() == true){
        return HomePage();                      // If the user as already visited the app, he starts with the Home page
      }else {
        return Coloc_Choice(uid : user.uid);                  // Else, he has to choose what coloc to display first, or create one
      //  return HomePage();
      }
    }
  }
}
