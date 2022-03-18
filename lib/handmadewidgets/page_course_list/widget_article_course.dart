import 'dart:ui';
import 'package:descoloc/models/grocerie_article.dart';
import 'package:descoloc/services/groceries_database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///Widget "Bouton tâche"
class ItemCourse extends StatefulWidget {
  final Groceries groceries;
  final String idColoc;
  const ItemCourse(this.groceries, this.idColoc);

  @override
  State<ItemCourse> createState() => _ItemCourseState();
}

class _ItemCourseState extends State<ItemCourse> {
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

    double hauteur = 0.1 * MediaQuery.of(context).size.height;
    /// final article = Article_preferences.thisArticle;
    return Material(
      child: InkWell(
        splashColor: Colors.red,
        highlightColor: Colors.cyanAccent,
        onTap: () {
          showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: Text('Suppression'),
                  content: Text(
                      'Voulez-vous supprimer ${widget.groceries.name} ?  Cette action sera définitive'),
                  actions: [
                    TextButton(
                      // Bouton pour annuler la suppression
                        onPressed: () async {
                          Navigator.of(context, rootNavigator: true).pop('dialog');
                        },
                        child: Text(
                          'Non',
                          style: TextStyle(color: Colors.red),
                        )),
                    TextButton(
                      // Bouton pour supprimer définitivement la colocatio
                      onPressed: () {
                        GroceriesServices(widget.idColoc).deleteGrocery(widget.groceries.id);
                        Navigator.of(context, rootNavigator: true).pop('dialog');
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
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: hauteur,
            decoration: const BoxDecoration(
              color: Colors.cyan,
            ),
            key: UniqueKey(),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 5
                          ),
                          child: Text(
                            widget.groceries.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 0.45* MediaQuery.of(context).size.width,
                          child: ClipRect(
                            child: Text(
                              widget.groceries.brand,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(1),
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: ElevatedButton(
                                  onPressed: _compteurMinus,
                                  child: const Icon(Icons.remove),
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(8, 8)),
                                      maximumSize: MaterialStateProperty.all(
                                          const Size(50, 50)))),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Center(
                                    child: Text(
                                  compteur.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )))),
                        Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: SizedBox(
                              height: 60,
                              width: 60,
                              child: ElevatedButton(
                                onPressed: _compteurPlus,
                                child: const Icon(Icons.add),
                                style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(8, 8)),
                                    maximumSize: MaterialStateProperty.all(
                                        const Size(50, 50))),
                              ),
                            )),
                      ],
                    ),
                  ],
                )),
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
/*
Widget affichage_courses(bool portrait, int number) {
  final items = List<Item_course>.generate(number, (i) => Item_course());
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
*/
