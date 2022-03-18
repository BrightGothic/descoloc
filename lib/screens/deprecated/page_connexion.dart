///This class is deprecated, it was the support of the dev of the frontend of sign in

/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:descoloc/pages/page_home.dart';
import 'package:flutter/src/widgets/framework.dart';

class Connexion extends StatefulWidget {
  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page de connexion',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Connexion'),
        ),
        body: Container(
          height: 1000,
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.all(20.0)),
              Center(
                key: UniqueKey(),
                child: const Text(
                  'Connexion',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              const Padding(padding: EdgeInsets.all(40.0)),
              Center(
                key: UniqueKey(),
                child: const Text(
                  'Adresse mail',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(
                top: 20.0,
              )),
              Center(
                key: UniqueKey(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    onChanged: (val){
                      /* setState(()
                        => email = val
                      );*/
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Votre adresse mail',

                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(22.0)),
              Center(
                key: UniqueKey(),
                child: const Text(
                  'Mot de Passe',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(
                top: 20.0,
              )),
              Center(
                key: UniqueKey(),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    onChanged: (val){
                   /*   setState(()
                  //    => password = val
                      );*/
                    },

                    obscuringCharacter: '*',
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Votre mot de passe',
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(
                top: 20.0,
              )),
              Center(
                  //     child: TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Connexion()));}, child: Text("Créer un compte")),
                  ),
              const Padding(
                  padding: EdgeInsets.only(
                top: 20.0,
              )),
             Builder(builder: (context) {
                return Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Text('SE CONNECTER')));
              }),


            ],
          ),
        ),
      ),
    );
  }
}
*/