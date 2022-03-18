import 'package:descoloc/models/colocataire.dart';
import 'package:descoloc/services/colocataire_database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardColocataire extends StatefulWidget {
  final String? idColoc;
  final Colocataire colocataire;
  final int index;
  const CardColocataire({required this.idColoc, required this.colocataire, required this.index, Key? key}) : super(key: key);

  @override
  _CardColocataireState createState() => _CardColocataireState();
}

class _CardColocataireState extends State<CardColocataire> {

  Color colorOfBox = Color(0xFF007FFF);
  Color colorOfTextInBox = Color(0xFFFFFFFF);
  double heightCard = 0.28;
  double widthCard = 0.43;

  @override
  Widget build(BuildContext context) {
    switch (widget.index){
      case 0 :
        colorOfBox = Color(0xFFFFD700);
        colorOfTextInBox = Color(0xFFFFFFFF);
        heightCard = 0.60;
        break;
      case 1 :
        colorOfBox = Color(0xFFC0C0C0);
        colorOfTextInBox = Color(0xFFFFFFFF);
        break;
      case 2 :
        colorOfBox = Color(0xFFB87333);
        colorOfTextInBox = Color(0xFFFFFFFF);
        break;
    }

    final contextHeight = 0.28 * MediaQuery.of(context).size.height;
    final contextWidth = 0.43 * MediaQuery.of(context).size.width;
        return Container(
          height: contextHeight,
          width: contextWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Card(
            color : colorOfBox,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextButton(
              onPressed: (){},
              onLongPress: () async {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text('Suppression'),
                        content: Text(
                            'Voulez-vous supprimer ${widget.colocataire.pseudo} ?  Cette action sera définitive. Toutes les données associées à ${widget.colocataire.pseudo} seront définitivement perdues. '),
                        actions: [
                          TextButton(
                            // Bouton pour annuler la suppression
                              onPressed: () async {
                                Navigator.of(ctx).pop();
                              },
                              child: Text(
                                'Non',
                                style: TextStyle(color: Colors.red),
                              )),
                          TextButton(
                            // Bouton pour supprimer définitivement la colocatio
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              ColocataireServices(idColoc: widget.idColoc).deleteColocataireFromColoc(widget.colocataire);
                              ColocataireServices(idColoc: widget.idColoc).deleteColocataireFromMembresColoc(widget.colocataire);
                            },
                            child: Text(
                              'Oui',
                              style: TextStyle(color: Color(0xFF2193F3)),
                            ),
                          )
                        ],
                      );
                    });
              },


              child: Padding(
                padding: const EdgeInsets.only(top : 9.0),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        minRadius: 20,
                        maxRadius: 40,
                        child: ClipOval(
                          child: Image.asset('assets/images/photos/photo_ville.jpg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                      Text(widget.colocataire.pseudo, style: TextStyle(fontWeight : FontWeight.bold, color: colorOfTextInBox),),
                      Text(widget.colocataire.score.toString() + ' points', style: TextStyle(color: colorOfTextInBox)),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: ElevatedButton(
                          child: Text('Profil'),
                          onPressed: (){

                          },
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        );

  }
}
