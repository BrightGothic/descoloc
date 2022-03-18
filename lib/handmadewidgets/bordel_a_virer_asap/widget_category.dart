import 'dart:ui';
import 'package:descoloc/classes/class_user.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:descoloc/classes/class_user.dart';

///Widget "Category"
class Category extends StatefulWidget {
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    bool _value = false;

    return Material(
      child: InkWell(
        splashColor: Colors.white,
        highlightColor: Colors.cyan,
        onTap: () {
          print("Cliqué Inkwell !");
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 85,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.cyan,
            ),
            key: UniqueKey(),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  children: [
                    Row(
                      children: <Widget>[
                        Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Icon(Icons.account_circle, size: 60),
                        ),
                        Column(
                          children: [
                            Padding(
                              key: UniqueKey(),
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 1.0, left: 1.0, right: 1.0),
                              child: const Text(
                                "data",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              key: UniqueKey(),
                              padding: const EdgeInsets.all(1.0),
                              child: const Text(
                                "data",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    Padding(key: UniqueKey(),padding: EdgeInsets.only(right: 160)),

                    InkWell(
                      onTap: () {
                        setState(() {
                          _value = !_value;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: _value
                              ? Icon(

                            Icons.check,
                            size: 35.0,
                            color: Colors.blue,
                            key : UniqueKey(),
                          )
                              : Icon(
                            Icons.check_box_outline_blank,
                            size: 35.0,
                            color: Colors.white,
                            key : UniqueKey(),
                          ),
                        ),
                      ),
                    )
                  ],
                )

            ),
          ),
        ),

      ),
    );
  }
}

///Affichage en liste
/* Widget affichage() {
  return ListView.builder(
    Category()[8],
  );
}
*/
Widget affichage(bool portrait) {
  final items = List<Category>.generate(10, (i) => Category());
  var itemsCount = items.length;
  if (portrait) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => items[index],
      itemCount: 10,

    );
  } else {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: items,
    );
  }
}

///Widgets
Widget monWidget() {
  return Center(
    child: Container(
      color: Colors.lightBlue,
      height: 100,
      width: 300,
      margin: const EdgeInsets.only(top: 5.0),
      child: const Center(
        child: Text(
          "Hey",
          textDirection: TextDirection.rtl,
        ),
      ),
    ),
  );
}

class MonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.deepOrangeAccent,
        height: 100,
        width: 300,
        margin: const EdgeInsets.only(top: 5.0),
        child: const Center(
          child: Text(
            "Hey",
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }
}

class MonWidgetStateful extends StatefulWidget {
  @override
  State<MonWidgetStateful> createState() => _MonWidgetStatefulState();
}

class _MonWidgetStatefulState extends State<MonWidgetStateful> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.greenAccent,
        height: 100,
        width: 300,
        margin: const EdgeInsets.only(top: 5.0),
        child: const Center(
          child: Text(
            "Hello",
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
    );
  }
}



///Colonnes de statistiques du profil
class Abonnes extends StatefulWidget{
  String student = 'JUL';

  @override
  State<Abonnes> createState() => _AbonnesState();
}

class _AbonnesState extends State<Abonnes> {

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Padding(
          key : UniqueKey(),
          padding: const EdgeInsets.all(8.0),

          child: Text('Abonnés', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          key: UniqueKey(),
          padding: const EdgeInsets.all(8.0),
          child:  Text('999', style: TextStyle(fontWeight: FontWeight.normal)),
        )
      ],
    );
  }
}

///Colonnes de statistiques du profil
class Abonnements extends StatefulWidget{
  String student = 'JUL';

  @override
  State<Abonnements> createState() => _AbonnementsState();
}

class _AbonnementsState extends State<Abonnements> {

  @override
  Widget build(BuildContext context){
   // final user = User_preferences.thisUser;
    return Column(
      children: <Widget>[
        Padding(
          key : UniqueKey(),
          padding: const EdgeInsets.all(8.0),

          child: Text('Abonnements', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          key: UniqueKey(),
          padding: const EdgeInsets.all(8.0),
          child:  Text('999', style: TextStyle(fontWeight: FontWeight.normal)),
        )
      ],
    );
  }
}



///Colonnes de statistiques du profil
class Points extends StatefulWidget{
  String student = 'JUL';

  @override
  State<Points> createState() => _PointsState();
}

class _PointsState extends State<Points> {

  @override
  Widget build(BuildContext context){
   return Column(
      children: <Widget>[
        Padding(
          key : UniqueKey(),
          padding: const EdgeInsets.all(8.0),

          child: Text('Points', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          key: UniqueKey(),
          padding: const EdgeInsets.all(8.0),
          child:  Text('999', style: TextStyle(fontWeight: FontWeight.normal)),
        )
      ],
    );
  }
}




Widget abonnesColonne(UserProfil user){
  var abonnes = Abonnes();
  abonnes.student = user.abonnes.toString();
  return abonnes;
}

