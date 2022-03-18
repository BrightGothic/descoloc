import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/handmadewidgets/page_course_list/widget_article_course.dart';
import 'package:descoloc/models/grocerie_article.dart';
import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:descoloc/services/auth.dart';
import 'package:descoloc/services/groceries_database_service.dart';
import 'package:descoloc/services/news_database_service.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GroceriesPageGraphism extends StatefulWidget {
  const GroceriesPageGraphism({Key? key}) : super(key: key);

  @override
  _GroceriesPageGraphismState createState() => _GroceriesPageGraphismState();
}

class _GroceriesPageGraphismState extends State<GroceriesPageGraphism> {
  ///Controllers for TextFields
  final articleController =
      TextEditingController(); // Controller of the Textfield into the dialog to add groceries  --> name
  final brandController =
      TextEditingController(); // Controller of the Textfield into the dialog to add groceries  --> brand

  ///Setup of the stream to get from Firestore
  ///Keep in mind that you must point it to the precise csubcollection of the articles in setStream
  ///Other ways, it will fail
  String? _nameUser;
  Stream<QuerySnapshot>? _stream; // Declare the stream we are about to use
  String? idColoc ;// declare the variable in which we will store the user id that we need to use GroceriesService
  void setStream() async {
    String userUID = await AuthService().getUser();
    String? prefidcoloc = await ManipulateSharedPreferences()
        .getIdColoc(); //get the current coloc uid
    Stream<QuerySnapshot> prefquerygroceries = FirebaseFirestore.instance
        .collection('colocs/')
        .doc(prefidcoloc)
        .collection('groceries')
        .doc('grocerieslist')
        .collection("articles")
        .orderBy('name')
        .snapshots(); //starts a stream to the location of the articles of this coloc groceries list


    QuerySnapshot<Map<String, dynamic>> queryUser = await FirebaseFirestore.instance
        .collection('colocs/' + prefidcoloc + '/colocataires')
        .where('uid', isEqualTo: userUID)
        .get();
    String nameUser = queryUser.docs.first['name'];

    setState(() {
      _nameUser = nameUser;
      _stream = prefquerygroceries; //setState
      idColoc = prefidcoloc; //setState
    });
  }

  ///Initiate the data from the async function setId
  @override
  void initState() {
    super.initState();
    setStream();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    articleController.dispose();
    brandController.dispose();
    super.dispose();
  }

  /// Setting up the date displayed on top of the page
  final DateTime now = DateTime.now();
  final DateFormat formatter =
      DateFormat('d'); //   DateFormat.yMMMMd('fr'); //DateFormat('yyyy-MM-dd');

  String getDate() {
    return formatter.format(now);
  }




  ///Building the heart of the widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                drawer: HomeDrawer(),
                body: StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    //stream: GroceriesServices(idColoc).idIndex,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.waiting ||
                          (idColoc == null))  {
                        return const Center(child:CircularProgressIndicator());
                      }

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
                            colors: [
                              Colors.indigoAccent,
                              Colors.lightBlueAccent
                            ],
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
                            child:
                                const Icon(Icons.menu, color: Colors.white),
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
                                  'Vos courses',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.2 *
                                          MediaQuery.of(context).size.width),
                                  child: Column(
                                    children:  [
                                      Text(
                                        snapshot.data!.size.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                      ),
                                      Text(
                                        'Articles dans votre panier',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
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
                            height: 1 * MediaQuery.of(context).size.height,
                            child: DraggableScrollableSheet(
                                initialChildSize: 0.8,
                                maxChildSize: 1,
                                minChildSize: 0.01,
                                builder: (BuildContext context,
                                    ScrollController scrollController) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        color: Color(0xF615354C),
                                        borderRadius:
                                            BorderRadius.circular(15),
                                      ),
                                      child: StreamProvider<List<Groceries>?>.value(
                                          //
                                          value: GroceriesServices(idColoc)
                                              .grocerieslist,
                                          initialData: null,
                                          child: SizedBox(
                                               height: 0.7 *
                                                   MediaQuery.of(context).size.height, //affichage_courses(true, number)

                                               /// Here insert the groceries cards which will be used to display the items
                                               child: Container(
                                                 decoration: BoxDecoration(

                                                   color: Color(0xF615354C),
                                                   borderRadius:
                                                   BorderRadius.circular(15),
                                                 ),
                                                 child: ListView(
                                                   children: snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
                                                     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                                     return ItemCourse(Groceries.fromJSON(data), idColoc!);
                                                   }).toList(),
                                                 ),
                                               ),
                                           ),
                                        ),
                                      );
                                })))
                  ]);
                });}),
              floatingActionButton:
              FloatingActionButton(
                child: Icon(Icons.shopping_bag),
                onPressed: () async {
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned(right: -40.0, top: -40.0,
                            child: InkResponse(
                              onTap: () {Navigator.of(context).pop();},
                              child: const CircleAvatar(
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Form(
                            //  key: _formKey,
                            child:
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: articleController,
                                    validator: (val) => val!.isEmpty ? 'Entrez un nom valide' : null,
                                    decoration: const InputDecoration(
                                        hintText: 'Article'
                                    ),),
                                ),
                                Padding(padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: brandController,
                                    decoration: const InputDecoration(
                                        hintText: 'Description'
                                    ),
                                  ),
                                ),
                                Padding(padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    child: const Text("Ajouter à la liste"),
                                    onPressed:
                                        () {
                                      String concatenated = articleController.text + DateTime.now().toString();
                                      GroceriesServices(idColoc).updateGroceriesData(concatenated, articleController.text, brandController.text, 'quantity', 'addedBy');
                                      NewsServices(idColoc: idColoc).updateNewsData(_nameUser??'user', 'groceries', articleController.text + ' ' +  brandController.text, Timestamp.now(), '0');
                                      articleController.clear();
                                      brandController.clear();
                                      Navigator.of(context, rootNavigator: true).pop('dialog');
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
              ),)

        ///Here ends the Stack


    ///End of StreamBuilder
  );
  }

}

///Here ends the Stack
