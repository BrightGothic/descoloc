import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/handmadewidgets/page_coloc_list/widget_new_card_colocataire.dart';
import 'package:descoloc/models/colocataire.dart';
import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:descoloc/services/colocataire_database_service.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GsColocsPage extends StatefulWidget {
  final String? idColoc;
  const GsColocsPage({required this.idColoc, Key? key}) : super(key: key);

  @override
  _GsColocsPageState createState() => _GsColocsPageState();
}

class _GsColocsPageState extends State<GsColocsPage> {



  ///Initiate the data from the async function setId
  @override
  void initState() {
    super.initState();
    //  setStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: ColocataireServices(idColoc: widget.idColoc).colocataires,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState ==
            ConnectionState.waiting ||
            (widget.idColoc == null))  {
          return const Text("Loading");
        }
        return MaterialApp(
          home: Scaffold(
              drawer: HomeDrawer(),
              body: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.indigoAccent, Colors.lightBlueAccent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(
                          builder: (context) {
                            return TextButton(
                              child: const Icon(Icons.menu,

                                  /// Button for the Drawer menu
                                  color: Colors.white),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            );
                          }
                      ),
                    ],),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(padding: EdgeInsets.only(top : 0.09 * MediaQuery.of(context).size.height)),
                      Center(
                        child: SizedBox(
                          height: 0.16 * MediaQuery.of(context).size.height,
                          width: 0.7 * MediaQuery.of(context).size.width,
                          child: Column(children: const [
                            Text('Coloc Members',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white)),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            Text('Retrouvez ici les personnes qui partagent votre vie !',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white)),

                          ]),
                        ),
                      ),
                      Container(
                        height: 0.065 * MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: (){
                                print('eee');
                              },
                              child: Icon(
                                Icons.add_circle_outline_outlined,
                                color: Colors.white ,
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          width: 0.95 * MediaQuery.of(context).size.width,
                          height: 0.685 * MediaQuery.of(context).size.height,
                          child: DraggableScrollableSheet(
                            initialChildSize: 1,
                            maxChildSize: 1,
                            minChildSize: 0.01,
                            builder: (BuildContext context,
                                ScrollController scrollController){
                              return Container(
                                //   width: 0.95 * MediaQuery.of(context).size.width,
                                //     height: 0.685 * MediaQuery.of(context).size.height,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                    color: Color(0xFF8CD2E7)),
                                // color: Color(0xFFFFE8D6)),
                                child: MaterialApp(
                                  home: StreamProvider<QuerySnapshot?>.value(
                                    value: ColocataireServices(idColoc : widget.idColoc)
                                        .colocataires,
                                    initialData: null,
                                    child : Padding(
                                      padding: const EdgeInsets.only(top :8.0),
                                      child: Center(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Wrap(
                                            direction: Axis.horizontal,
                                            alignment: WrapAlignment.spaceAround,
                                            spacing: 8,
                                            children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                              /// C'est tres bizarre, si j'envoie juste une donnée du coloc à la carte d'affichage
                                              /// il n'y a pas d'erreur, mais si j'envoie le Coloc complet il y a erreur
                                              /// The following _TypeError was thrown building CardColocataire(dirty, dependencies: [MediaQuery], state: _CardColocataireState#485a3):
                                              /// type 'Null' is not a subtype of type 'Colocataire' of 'function result'
                                              return CardColocataire(idColoc : widget.idColoc,colocataire : Colocataire.fromJSON(data), index : 0);
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                    ],
                  ),

                ],
              )

          ),

        );
      },
    );
  }
}
