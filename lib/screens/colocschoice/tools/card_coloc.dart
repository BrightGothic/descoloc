import 'package:descoloc/models/coloc.dart';
import 'package:descoloc/screens/deprecated/page_home.dart';
import 'package:descoloc/services/coloc_database_service.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardColoc extends StatelessWidget {
  final Coloc coloc;

  const CardColoc({required this.coloc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FlutterLogo(),
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        ManipulateSharedPreferences().setIdColoc(coloc.id);
      },
      title: Text(coloc.name),
      trailing: IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text('Suppression'),
                  content: Text(
                      'Voulez-vous supprimer ${coloc.name} ?  Cette action sera définitive'),
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
                        ColocServices().deleteColoc(coloc.id);
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
    );
  }
}
