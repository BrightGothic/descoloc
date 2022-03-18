import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/handmadewidgets/page_tasks_list/widget_task.dart';
import 'package:descoloc/models/task.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:descoloc/services/tasks_database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:provider/provider.dart';

class Accueil extends StatefulWidget {
  const Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {


  late final Stream<QuerySnapshot> _tasks;
  late final String idColoc;

  void setId() async {
    String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc();
    print('prefid : ' + prefidcoloc);
    Stream<QuerySnapshot> prefquerytasks = FirebaseFirestore.instance
        .collection('colocs/'+prefidcoloc+'/tasks')
        .snapshots();
    setState(() {
      _tasks = prefquerytasks;
      idColoc = prefidcoloc;
    });
  }

  @override
  void initState()  {
    super.initState();
    setId();
  }





  @override
  Widget build(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
                stream: _tasks,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return MaterialApp(
                    theme: ThemeData(primarySwatch: Colors.blue),
                    home:

                    StreamProvider<List<Task>?>.value(
                      value: TaskServices(idColoc: idColoc).tasks,
                      initialData: null,
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                  key: UniqueKey(),
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                  )),
                              const Text(
                                '  Vos tâches du jour',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blue),
                              ),
                              Padding(
                                  key: UniqueKey(),
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                  )),
                              Stack(
                                children: <Widget>[
                                  SizedBox(
                                      height: 300,
                                      child: ListView(
                                        children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                          return Item_Tasks(data['name'],data['property']);

                                        }).toList(),
                                      ) //TaskList() //affichage_tasks(true,11)
                                  ),
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
                              Padding(
                                  key: UniqueKey(),
                                  padding: const EdgeInsets.only(
                                    top: 20.0,
                                  )),
                              const Text(
                                '  Les actus de la Coloc',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              InkWell(
                                splashColor: Colors.cyan,
                                child: Container(
                                  height: 220,
                                  width: 380,
                                  decoration: const BoxDecoration(
                                    color: Colors.cyan,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    ///fin Stream Provider
                  );

                  ///Fin material app
                });

  }
}
