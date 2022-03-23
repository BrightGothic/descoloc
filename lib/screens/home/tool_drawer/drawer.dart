import 'package:descoloc/models/user.dart';
import 'package:descoloc/screens/deprecated/photobooth/page_photobooth.dart';
import 'package:descoloc/screens/home/accueil/graphism_update/new_page_accueil.dart';
import 'package:descoloc/screens/home/coloc/graphics_update/new_page_colocs.dart';
import 'package:descoloc/screens/home/groceries/groceries_graphic_update/new_page_groceries.dart';
import 'package:descoloc/screens/home/memories/screens/stories/gs_stories.dart';
import 'package:descoloc/screens/home/tasks/graphism_update/new_page_tasks.dart';
import 'package:descoloc/screens/profil/page_profil.dart';
import 'package:descoloc/services/auth.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late String idColoc;
  UserInApp? userInApp;

  final AuthService _auth = AuthService();

  Future<bool> getUser() async {
    User? user = await _auth.user;
    String _idColoc = await ManipulateSharedPreferences().getIdColoc();
    String userUID = AuthService().idfromFirebase(user);
    final userfinal = await AuthService().getUserfromId(userUID);
    setState(() {
      userInApp = userfinal as UserInApp;
      idColoc = _idColoc;
    });
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.indigoAccent,
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: getUser(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot){
                if(snapshot.hasData){
                  return UserAccountsDrawerHeader(
                    accountName: Text(userInApp!.name),
                    accountEmail: Text(userInApp!.pseudo),
                    currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/luckyloc-8bfd2.appspot.com/o/vIq0A7F9ubVlmlAQ2e9O%2Fseoul%2Ft%C3%A9l%C3%A9chargement%20(1).jpg?alt=media&token=a232a367-7592-4209-a60a-221cbe27f514',
                          fit : BoxFit.cover,
                          height : 300,
                          width : 300,
                        ),
                      ),
                    ),
                  );
                }
                return Text('Error drawer');
              }
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text(
                      'Accueil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AccueilPageGraphism()));},
                  ),
                  ListTile(
                    title: const Text(
                      'Taches',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => TasksPageGraphism()));},
                  ),
                  ListTile(
                    title: const Text(
                      'Stories(New-GS)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GsStoriesPage(idColoc: idColoc)));
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'PhotoBooth(Old)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoBoothPage()));
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Courses',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GroceriesPageGraphism()));
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Ma coloc',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ColocsPageGraphics(idColoc: this.idColoc,)));

                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Profil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
