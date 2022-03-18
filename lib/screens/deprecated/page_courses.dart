import 'dart:io';
import 'dart:collection';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/grocerie_article.dart';
import 'package:descoloc/services/groceries_database_service.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:descoloc/handmadewidgets/page_course_list/widget_article_course.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {

  ///Controllers for TextFields
  final articleController = TextEditingController();  // Controller of the Textfield into the dialog to add groceries  --> name
  final brandController = TextEditingController();    // Controller of the Textfield into the dialog to add groceries  --> brand

  ///Setup of the stream to get from Firestore
  ///Keep in mind that you must point it to the precise csubcollection of the articles in setStream
  ///Other ways, it will fail

  late final Stream<QuerySnapshot> _stream; // Declare the stream we are about to use
  late final String idColoc; // declare the variable in which we will store the user id that we need to use GroceriesService


  void setStream() async {
    String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc(); //get the current coloc uid
    Stream<QuerySnapshot> prefquerytasks =
    FirebaseFirestore.instance
        .collection('colocs/')
        .doc(prefidcoloc)
        .collection('groceries')
        .doc('grocerieslist')
        .collection("articles")
        .snapshots();               //starts a stream to the location of the articles of this coloc groceries list
    setState(() {
      _stream = prefquerytasks;  //setState
      idColoc = prefidcoloc;     //setState
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    articleController.dispose();
    brandController.dispose();
    super.dispose();
  }

  @override
  void initState() {   //initiate the value of the stream
    super.initState();
    setStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _stream,  //this stream is indexed on the groceries list of articles subcollection
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          /// List of cases we can face will attempting to get a snapshot from FirebaseFirestore
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (snapshot.connectionState == ConnectionState.none) {
            return const Text("Bugged");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const Text("Done");
          }

          ///If the snapshot is gotten right

          if (snapshot.connectionState == ConnectionState.active) {

            return MaterialApp(
              theme: ThemeData(primarySwatch: Colors.blue),
              home: StreamProvider<List<Groceries>?>.value( //
                value: GroceriesServices(idColoc).grocerieslist,
                initialData: null,
                child: Stack(
                  children: <Widget>[
                    Scaffold(
                      body: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(top: 60, right: 20),
                              ),
                              Title(
                                  color: Colors.blue,
                                  child: const Text(
                                    'Liste de courses',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          Container(
                              child: SizedBox(
                                height: 560,
                                //affichage_courses(true, number)

                                /// Here insert the groceries cards which will be used to display the items
                                child: ListView(
                                  children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    print('this is the data' + data.toString());
                                    return ItemCourse(
                                        Groceries.fromJSON(data), idColoc);
                                  }).toList(),
                                ),
                              ))
                        ],
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () async {
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
                                          child: const CircleAvatar(
                                            child: Icon(Icons.close),
                                            backgroundColor: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Form(
                                        //  key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: articleController,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: brandController,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: ElevatedButton(
                                                child: Text("Submit"),
                                                onPressed: () {
                                                  /*   if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                      }*/
                                                  final concatenated =articleController.text + DateTime.now().toString();
                                                  GroceriesServices(idColoc)
                                                      .updateGroceriesData(
                                                      concatenated,
                                                      articleController.text,
                                                      brandController.text,
                                                      'quantity',
                                                      'addedBy');
                                                  Navigator.of(context,
                                                      rootNavigator: true)
                                                      .pop('dialog');
                                                  //   dispose();
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
                        //_numberPlus, ///Add an article to the groceries list //Here end the floating action button
                        backgroundColor: Colors.white,
                      ),
                    ),

                    ///Here ends the Scaffold
                  ],
                ),
              ),
            );
          }
          return Text('None of the input cases');

          ///Here ends the Stack
        });

    ///Here ends the Stack
  }

  ///Here ends the build()
}
