import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/handmadewidgets/page_coloc_list/widget_new_card_colocataire.dart';
import 'package:descoloc/models/colocataire.dart';
import 'package:descoloc/models/user.dart';
import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:descoloc/services/colocataire_database_service.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColocsPageGraphics extends StatefulWidget {
  final String idColoc;
  const ColocsPageGraphics({required this.idColoc, Key? key}) : super(key: key);

  @override
  _ColocsPageGraphicsState createState() => _ColocsPageGraphicsState();
}

class _ColocsPageGraphicsState extends State<ColocsPageGraphics> {

  ///Controllers for TextFields
  final colocController =
  TextEditingController(); // Controller of the Textfield into the dialog to add story  --> name

  ///Initiate the data from the async function setId
  @override
  void initState() {
    super.initState();
  //  setStream();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return StreamBuilder<QuerySnapshot>(
      stream: ColocataireServices(idColoc: widget.idColoc).colocataires,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
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
            (widget.idColoc == null))  {
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
        return Scaffold(
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
                                onPressed: ()async {
                                  showDialog(context: context, builder: (BuildContext context) {
                                    return FindUser(idColoc:widget.idColoc);
                                  });
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
                                child: StreamProvider<QuerySnapshot?>.value(
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
                                                print(index);
                                                  index +=1;
                                                return CardColocataire(idColoc : widget.idColoc, colocataire : Colocataire.fromJSON(data), index: index -1 );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),

                                  ),
                              );},
                            ),
                          ),
                        ),
                    ],),
            ],),
          );


  },
    );
  }
}

class FindUser extends StatefulWidget {
  final String idColoc;
  const FindUser({required this.idColoc, Key? key}) : super(key: key);

  @override
  _FindUserState createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {

  late List<UserInApp> pickedUsers = List.empty(growable: true);

  ///Controllers for TextFields
  final colocController =
  TextEditingController(); // Controller of the Textfield into the dialog to add story  --> name

  ///Making the users invisible when the searchbar is empty
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
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
                                  color : Colors.grey
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

                Padding(padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Ajouter le membre"),
                    onPressed:
                        () {
                      for (var user in pickedUsers ){
                        ColocataireServices(idColoc: widget.idColoc).updateColocataireData(user.uid, user.name, user.pseudo, 0,0, Timestamp.now());
                      }
                      colocController.clear();
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
  }
}
