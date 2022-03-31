import 'package:descoloc/classes/class_wrapper_yt.dart';
import 'package:descoloc/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:descoloc/models/user.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserInApp?>.value(
      value: AuthService().userStream,
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:Wrapper(),
        ));
  }
}

