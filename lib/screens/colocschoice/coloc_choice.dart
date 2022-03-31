import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/user.dart';
import 'package:descoloc/screens/accueil/graphism_update/new_page_accueil.dart';
import 'package:descoloc/screens/deprecated/page_home.dart';
import 'package:descoloc/screens/profil/page_profil.dart';
import 'package:descoloc/screens/colocschoice/add_colocation.dart';
import 'package:descoloc/services/auth.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:descoloc/services/coloc_database_service.dart';

class Coloc_Choice extends StatefulWidget {
  final String uid;
  const Coloc_Choice({Key? key, required this.uid}) : super(key: key);

  @override
  _Coloc_ChoiceState createState() => _Coloc_ChoiceState();
}

class _Coloc_ChoiceState extends State<Coloc_Choice> {

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> colocsStream =
    FirebaseFirestore.instance.collection('colocs').where('membres', arrayContains : widget.uid).snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vos colocations'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: colocsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Something went wrong :(')),
              ],
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text('Loading...')),
              ],
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ListTile(
                    leading: FlutterLogo(),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AccueilPageGraphism()));
                      ManipulateSharedPreferences().setIdColoc(data['id']);
                    },
                    title: Text(data['name']),
                    trailing: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text('Suppression'),
                                content: Text(
                                    'Voulez-vous supprimer ${data['name']} ?  Cette action sera définitive'),
                                actions: [
                                  TextButton(
                                      // Bouton pour annuler la suppression
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Non',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  TextButton(
                                    // Bouton pour supprimer définitivement la colocatio
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      ColocServices().deleteColoc(data['id']);
                                    },
                                    child: Text(
                                      'Oui',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        tooltip: 'Increment',
        onPressed: () async {
          ManipulateSharedPreferences().setalreadyVisited(true);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddColocation()));
        },
        label: Row(
          children: [
            Text('Ajouter une colocation '),
            Icon(Icons.add_circle_outline_outlined)
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.,
    );
  }
}
