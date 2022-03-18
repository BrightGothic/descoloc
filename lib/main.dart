import 'package:descoloc/classes/class_wrapper_yt.dart';
import 'package:descoloc/screens/authenticate/graphism_update/new_page_signin.dart';
import 'package:descoloc/screens/home/accueil/graphism_update/new_page_accueil.dart';
import 'package:descoloc/screens/home/coloc/addcolocataires.dart';
import 'package:descoloc/screens/home/coloc/graphics_update/new_page_colocs.dart';
import 'package:descoloc/screens/home/groceries/groceries_graphic_update/new_page_groceries.dart';
import 'package:descoloc/screens/home/photobooth/page_photobooth.dart';
import 'package:descoloc/screens/home/photobooth/page_story/page_story.dart';
import 'package:descoloc/screens/home/photobooth/tools/manipulate_images_library.dart';
import 'package:descoloc/screens/home/tasks/graphism_update/new_page_tasks.dart';
import 'package:descoloc/screens/home/tasks/task_form.dart';
import 'package:descoloc/screens/profil/page_profil.dart';
import 'package:descoloc/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:descoloc/models/user.dart';

import 'godsama/screens/stories/gs_stories.dart';


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

