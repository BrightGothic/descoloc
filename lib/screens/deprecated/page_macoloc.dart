import 'package:descoloc/handmadewidgets/page_coloc_list/widget_coloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../coloc/addcolocataires.dart';

class Macoloc extends StatefulWidget {
  @override
  State<Macoloc> createState() => _MacolocState();
}

class _MacolocState extends State<Macoloc> {
  int number = 2;

  void _numberPlus() {
    setState(() {
      this.number += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 60, right: 20),
                ),
                Title(
                    color: Colors.blue,
                    child: const Text(
                      'Membres de la coloc',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                    child: SizedBox(
                        height: 450, child: affichage_colocs(true, number))),
                const Positioned.fill(
                  child: Icon(
                    Icons.arrow_circle_down,
                    color: Colors.white,
                  ),
                  left: 20,
                  top: 250,
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            MaterialButton(
              height: 60.0,
              minWidth: 200.0,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: new Text(
                "Ajouter un membre",
                style: TextStyle(fontSize: 25),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddColocatairesPage()));
                _numberPlus;
              },
              splashColor: Colors.white54,
            )
          ]),
        ),
      ],
    );
  }
}
