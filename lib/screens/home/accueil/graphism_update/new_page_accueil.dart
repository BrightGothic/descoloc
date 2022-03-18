import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/news.dart';
import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:descoloc/services/news_database_service.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'newstile_nonscrollable.dart';

class AccueilPageGraphism extends StatefulWidget {
  const AccueilPageGraphism({Key? key}) : super(key: key);

  @override
  _AccueilPageGraphismState createState() => _AccueilPageGraphismState();
}

class _AccueilPageGraphismState extends State<AccueilPageGraphism> {




  /// Setting up the date displayed on top of the page
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat(
      'MMMEd'); //   DateFormat.yMMMMd('fr'); //DateFormat('yyyy-MM-dd');

  String getDate() {
    return formatter.format(now);
  }

  ///setting up the Stream we get the news of the colocation from
  ///
  Stream<QuerySnapshot>? _newslist;
  String? idColoc;
  void setId() async {
    String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc();
    Stream<QuerySnapshot> prefquerytasks = FirebaseFirestore.instance
        .collection('colocs/' + prefidcoloc + '/news')
        .snapshots();
    setState(() {
      _newslist = prefquerytasks;
      idColoc = prefidcoloc;
    });
  }


  ///Initiate the data from the async function setId
  @override
  void initState() {
    super.initState();
    setId();
  }

  ///Building the heart of the widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
            drawer: const HomeDrawer(),
            body: Material(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _newslist,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(body: Stack(
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
                          Center(child: const Text('Something went wrong',style: TextStyle(color:Colors.white),)),
                        ],
                      ));
                    }

                    if (snapshot.connectionState ==
                        ConnectionState.waiting ||
                        (this.idColoc == null))  {
                      return Scaffold(body: Stack(
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
                          Center(child: const Text('Loading...', style: TextStyle(color:Colors.white),)),
                        ],
                      ));
                    }
                    if (snapshot.connectionState ==
                        ConnectionState.active) {
                      return Builder(builder: (context) {
                return Stack(children: [
                  /// This part is dedicated to the top part of the page. It displays the date of the day and
                  /// the number of tasks to do
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          //colors: [Colors.purple, Colors.deepPurple],
                          colors: [Colors.indigoAccent, Colors.lightBlueAccent],
                          //colors: [Color(0xF615354C), Colors.lightBlueAccent],  Bleu foncé du center vers bleu clair
                          //colors: [Color(0xF625154C), Color(0xF615354C)], Dark,
                          //colors: [Color(0xF6363A3D), Color(0xF638383E)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      // border: BoxBorder()
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Button for the Drawer menu
                        TextButton(
                          child: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                              child: Column(
                            children: [
                              Text(
                                getDate(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        0.2 * MediaQuery.of(context).size.width),
                                child: Row(children: <Widget>[
                                  Column(
                                    children: [
                                      Text(
                                        snapshot.data!.size.toString(),
                                        style:const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                      const Text(
                                        'Tâches à faire',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Flexible(
                                          child: VerticalDivider(
                                            thickness: 3,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Flexible(
                                          // Ne me demandez pas pq mais le Vertical Divider ne fonctionne pas sans ce widget
                                          child: Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: 35, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: const [
                                      Text(
                                        '19',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                      Text(
                                        'Courses à faire',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ]),
                              )
                            ],
                          )),
                        ),

                        // Text(_date.toString())
                      ],
                    ),
                  ),

                  /// This part is dedicated to display the news of the coloc
                  ///
                  Center(
                    child: SizedBox(
                      width: 0.9 * MediaQuery.of(context).size.width,
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.8,
                        maxChildSize: 1,
                        minChildSize: 0.01,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: const Color(0xF615354C),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: StreamProvider<List<News>?>.value(
                                                value: NewsServices(idColoc: idColoc)
                                                    .newslist,
                                                initialData: null,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Column(
                                                      children: <Widget>[
                                                        Padding(
                                                            key: UniqueKey(),
                                                            padding:
                                                                const EdgeInsets.only(
                                                              top: 10.0,
                                                            )),
                                                        const Text(
                                                          'Les actus de la coloc ! ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 20,
                                                              color: Colors.white),
                                                        ),

                                                        Flexible(
                                                          child: ListView(
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                                                               Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                                               return NewsTileNS(idColoc : idColoc!, news : News.fromJSON(data));
                                                            }).toList(),
                                                          ),
                                                        ),
                                                        Padding(
                                                            key: UniqueKey(),
                                                            padding:
                                                                const EdgeInsets.only(
                                                              top: 10.0,
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),


                          );
                        },
                      ),
                    ),
                  ),
                ]);
              });
                }

                ///Fin material app

                return Container();
              }),
            )),
    );
  }
}
