import 'package:descoloc/models/coloc.dart';
import 'package:descoloc/models/task.dart';
import 'package:descoloc/screens/deprecated/page_courses.dart';
import 'package:descoloc/screens/deprecated/page_listcoloc_yt.dart';
import 'package:descoloc/screens/deprecated/page_macoloc.dart';
import 'package:descoloc/screens/deprecated/page_tasks.dart';
import 'package:descoloc/services/auth.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:descoloc/handmadewidgets/bordel_a_virer_asap/widget_category.dart';
import '../profil/page_profil.dart';
import 'package:descoloc/screens/deprecated/page_accueil.dart';
import 'package:descoloc/services/tasks_database_service.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home/accueil/graphism_update/new_page_accueil.dart';

class HomePage extends StatefulWidget {
  final idColoc;
  HomePage({this.idColoc});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthService _auth = AuthService();

  int _selectedIndex = 0; //New
  //New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  static List<Widget> _pages = <Widget>[
    Accueil(),
    Tasks(),
    Courses(),
    Macoloc(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:Scaffold(
          appBar: AppBar(
            title: const Text('Votre Coloc'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccueilPageGraphism()));
                }
              ),
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));},
              ),
            ],
          ),
          body: Center(
                child: _pages.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task),
                label: 'Tâches',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Courses',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Coloc',
              ),
            ],
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,         //New
          ),
        ),
      );

  }
}
