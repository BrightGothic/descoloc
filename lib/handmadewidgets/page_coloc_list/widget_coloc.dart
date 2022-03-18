import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Item_Colocs extends StatefulWidget {
  @override
  State<Item_Colocs> createState() => _Item_ColocsState();
}

class _Item_ColocsState extends State<Item_Colocs> {
  double hauteur = 75;
  double largeur = 300;
  int compteur = 1;

  void _compteurMinus() {
    setState(() {

      compteur -= 1;
    });
  }

  void _compteurPlus() {
    setState(() {

      compteur += 1;
    });
  }


  @override
  Widget build(BuildContext context) {
    bool _value = false;
    return Material(
      child: InkWell(
        splashColor: Colors.red,
        highlightColor: Colors.cyanAccent,
        onTap: () {
          print("Cliqué Inkwell !");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        key: UniqueKey(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(initialValue: 'Article',),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(initialValue: 'Marque',),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {

                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });

        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: this.hauteur,
            width: this.largeur,
            decoration: BoxDecoration(
              //    borderRadius: BorderRadius.circular(50.0),
              color: Colors.black12,
            ),
            key: UniqueKey(),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                        Center(
                          child:
                            Padding(
                              key: UniqueKey(),
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 1.0,
                                  left: 10.0,
                                  right: 1.0),
                              child:  const Text(
                                'Amelie',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),

                        ),
                        Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 1.0,
                              left: 1.0,
                              right: 10.0),
                          child:  const Text(
                            '300 points',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],

                )),
          ),
        ),
      ),
    );
  }
}






Widget affichage_colocs(bool portrait, int number) {
  final items = List<Item_Colocs>.generate(number, (i) => Item_Colocs());
  var itemsCount = items.length;
  if (portrait) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => items[index],
      itemCount: number,
    );
  } else {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: items,
    );
  }
}