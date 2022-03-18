import 'package:descoloc/godsama/models/pictures.dart';
import 'package:descoloc/godsama/models/stories.dart';
import 'package:descoloc/godsama/services/gs_firestorage_services.dart';
import 'package:descoloc/godsama/services/gs_pictures_services.dart';
import 'package:flutter/material.dart';

class GsPictureCard extends StatefulWidget {
  final String idColoc;
  final Stories stories;
  final Pictures pictures;
  const GsPictureCard(
      {required this.idColoc,
      required this.stories,
      required this.pictures,
      Key? key})
      : super(key: key);

  @override
  _GsPictureCardState createState() => _GsPictureCardState();
}

class _GsPictureCardState extends State<GsPictureCard> {
  late final Future<String> _pictureURL;

  void didChangeDependencies() async {
    final Future<String> pictureURL = GsFirestorageServices().downloadURL(
        widget.idColoc, widget.stories.id, widget.pictures.id);
    setState(() {
      _pictureURL = pictureURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      child: Card(
        semanticContainer: true,
        //  clipBehavior: Clip.antiAlias,
        elevation: 6,
        color: Colors.black,
        child: FutureBuilder(
          future: _pictureURL,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3)
                ),
                child: Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width ,
                        height: MediaQuery.of(context).size.width ,
                        child: Image.network(snapshot.data!, fit: BoxFit.cover)),
                    TextButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Image.network(snapshot.data!, fit: BoxFit.fill)
                                ],
                              ),
                            );
                          },
                        );
                      },
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text('Suppression'),
                                content: Text(
                                    'Voulez-vous supprimer ${widget.pictures.name} ?  Cette action sera définitive'),
                                actions: [
                                  TextButton(
                                    // Bouton pour annuler la suppression
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Non',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  TextButton(
                                    // Bouton pour supprimer définitivement la colocatio
                                    onPressed: () async {
                                      await GsPicturesServices().deletePicture(widget.idColoc, widget.stories.id, widget.pictures);
                                      Navigator.of(context, rootNavigator: true).pop('dialog');
                                    },
                                    child: const Text(
                                      'Oui',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(),/* SizedBox(
                        height: 200,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              verticalDirection: VerticalDirection.up,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                ),
                                Text(
                                  'Voyage à ${widget.pictures.name}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),*/
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
