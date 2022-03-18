import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/user.dart';
import 'package:descoloc/screens/colocschoice/coloc_choice.dart';
import 'package:descoloc/services/auth.dart';
import 'package:descoloc/services/coloc_database_service.dart';
import 'package:descoloc/services/colocataire_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddColocation extends StatefulWidget {
  const AddColocation({Key? key}) : super(key: key);

  @override
  _AddColocationState createState() => _AddColocationState();
}

class _AddColocationState extends State<AddColocation> {
  String nameColoc = "nameColocInitial";
  final myController_name =  TextEditingController(); //This controler allows us to access the data of the textfield to create the coloc
  late List<UserInApp> pickedUsers = List.empty(growable: true);

  ///Controllers for TextFields
  final colocController =
  TextEditingController(); // Controller of the Textfield into the dialog to add story  --> name

  ///Making the users invisible when the searchbar is empty
  bool isVisible = false;


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController_name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Créer une colocation'),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(30),),
                  const Text(
                    "Encore un petit effort !",
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),

                  /// Choosing the name of the coliving

                  Padding(padding: EdgeInsets.all(20),),
                  const Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text ('Nom de la colocation',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Container(
                      height: 40,
                      width: 0.90 * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child:Padding(
                        padding: const EdgeInsets.only(left : 5.0),
                        child: TextField(
                            controller : myController_name,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Entrez du texte ici')
                        ),
                      )
                  ),
                  Padding(padding: EdgeInsets.all(20),),

                  ///Add mate
                  Padding(padding: EdgeInsets.all(20),),
                  const Padding(
                    padding: const EdgeInsets.only(left: 50, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text ('Ajoutez des colocataires !',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      //  key: _formKey,
                      child:
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: colocController,
                              validator: (val) => val!.isEmpty ? 'Entrez un nom valide' : null,
                              onFieldSubmitted: (String _){
                                setState((){
                                  isVisible = true;
                                });},
                              decoration: const InputDecoration(
                                  hintText: "Pseudo de l'utilisateur"
                              ),),
                          ),
                          /// HERE WE DISPLAY THE RESULTS OF THE USER SEARCH BY PSEUDO
                          SizedBox(
                            height: 210,
                            child: isVisible ? FutureBuilder(
                              future : FirebaseFirestore.instance.collection('users')
                                  .where('pseudo', isEqualTo : colocController.text)
                                  .get(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                                if(!snapshot.hasData){
                                  return Center(
                                    child : CircularProgressIndicator(),
                                  );
                                }else{
                                  return Container(
                                    height: 110,
                                    width: 220,
                                    child: ListView.builder(
                                      itemCount : snapshot.data!.size,
                                      itemBuilder: (BuildContext context, int index) {
                                        return SizedBox(

                                            child: TextButton(
                                              onPressed: (){
                                                final List<UserInApp> picked = pickedUsers;
                                                final UserInApp user = UserInApp(
                                                    uid : snapshot.data!.docs[index]['uid'],
                                                    name : snapshot.data!.docs[index]['name'],
                                                    pseudo : snapshot.data!.docs[index]['pseudo'] );

                                                picked.add(
                                                    UserInApp(
                                                        uid: snapshot.data!
                                                            .docs[index]['uid'],
                                                        name: snapshot.data!
                                                            .docs[index]['name'],
                                                        pseudo: snapshot.data!
                                                            .docs[index]['pseudo']));
                                                setState(() {
                                                  pickedUsers = picked;
                                                });
                                                print(pickedUsers.toString());
                                              },
                                              child: Text(snapshot.data!.docs[index]['pseudo']),
                                            )
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                            ) : Container(),
                          ),
                          ///END OF THE RESULTS DISPLAY


                          SizedBox(
                            height: 50,
                            width: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount : pickedUsers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 25,

                                  child: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                        color: Colors.blue,
                                        width: 5,
                                      ),
                                          color : Colors.white
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left : 8.0),
                                            child: Text(pickedUsers[index].pseudo),
                                          ),
                                          TextButton(onPressed: () {
                                            final List<UserInApp> picked = pickedUsers;
                                            picked.removeAt(index);
                                            setState((){
                                              pickedUsers = picked;
                                            });
                                          },
                                              child: Icon(Icons.clear))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  /// Add coloc to DB using coloc_database_services

                  ElevatedButton(
                      onPressed: () async {
                        String user = await AuthService().getUser();
                        ColocServices().addColoc(myController_name.text, user);
                        for (var user in pickedUsers ){
                         // ColocataireServices(idColoc: widget.idColoc).updateColocataireData(user.uid, user.name, user.pseudo, 0,0, Timestamp.now());
                        }
                        colocController.clear();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Coloc_Choice(uid : user)));
                        },
                      child: Text('Créer')),


                ]
            )
        )
    );
  }
}
