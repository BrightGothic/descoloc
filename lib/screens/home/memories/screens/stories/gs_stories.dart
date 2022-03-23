import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/screens/home/memories/models/stories.dart';
import 'package:descoloc/screens/home/memories/services/gs_stories_services.dart';

import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:flutter/material.dart';

import 'local_widget/gs_story_card.dart';

class GsStoriesPage extends StatefulWidget {
  final String idColoc;
  const GsStoriesPage({required this.idColoc, Key? key}) : super(key: key);

  @override
  _GsStoriesPageState createState() => _GsStoriesPageState();
}

class _GsStoriesPageState extends State<GsStoriesPage> {

  ///Controllers for TextFields
  final storyController =
  TextEditingController(); // Controller of the Textfield into the dialog to add story  --> name
  final _formKey = GlobalKey<FormState>();

  late final Future<List<Stories>> _stories;

  void didChangeDependencies() async {

    super.didChangeDependencies();
    final stories = GsStoriesServices().getStories(widget.idColoc);
    setState((){
      _stories = stories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigoAccent, Colors.lightBlue])
            ),
          ),

          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    child: const Icon(Icons.menu,

                        /// Button for the Drawer menu
                        color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Center(
                    child: SizedBox(
                      height: 0.2 * MediaQuery.of(context).size.height,
                      width: 0.7 * MediaQuery.of(context).size.width,
                      child: Column(children: const [
                        Text('Coloc Stories',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white)),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Text('Retrouvez ici les moments partagés ensemble !',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white))
                      ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 0.5 * MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: _stories,
                  builder: (BuildContext context, AsyncSnapshot<List<Stories>> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length + 1 ,
                        itemBuilder: (BuildContext context, int index) {
                          if(snapshot.data!.length == 0){
                            return const Padding(
                              padding: const EdgeInsets.only(top : 150),
                              child: Center(
                                  child : Text('Créez votre première story ! ',
                                    style: TextStyle(
                                      color : Colors.white,
                                      fontSize: 18,
                                    ),)),
                            );
                          }
                          if (index == 0 ) {
                            return StoryCard(stories : snapshot.data![index], idColoc: widget.idColoc,);
                          }if (index >= 2) {
                            return StoryCard(stories: snapshot.data![index - 1], idColoc: widget.idColoc,);
                          }else{
                            return(Container());
                          }
                        },
                      );
                    }if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }if(snapshot.connectionState == ConnectionState.none){
                      return Center(
                        child: Text('none'),
                      );
                    }
                    else{
                      return Center(
                        child: Text(snapshot.connectionState.toString()),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()async {
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
                      key: _formKey,
                      child:
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: storyController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                   return 'Entrez un nom valide';
                                }
                                if (val.length > 20) {
                                  return 'Le nom doit faire moins de 14 char';
                                }
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Story'
                              ),),
                          ),
                          Padding(padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: const Text("Ajouter la story"),
                              onPressed:
                                  () {
                                if (_formKey.currentState!.validate()){
                                  String concatenated = storyController.text + DateTime.now().toString();
                                  GsStoriesServices().updateStoriesData(widget.idColoc, storyController.text, storyController.text, Timestamp.now(), Timestamp.now());
                                  storyController.clear();
                                  Navigator.of(context, rootNavigator: true).pop('dialog');
                                }
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
        child: Icon(Icons.add),
      ),
    );
  }
}
