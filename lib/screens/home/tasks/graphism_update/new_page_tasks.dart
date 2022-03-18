import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/handmadewidgets/page_tasks_list/new_task_list_item_graphic/graphic_widget_task.dart';
import 'package:descoloc/handmadewidgets/page_tasks_list/new_task_list_item_graphic/v3_task_list_item/widget_task_v3.dart';
import 'package:descoloc/models/task.dart';
import 'package:descoloc/screens/home/tasks/task_form.dart';
import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:descoloc/services/auth.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:descoloc/services/tasks_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TasksPageGraphism extends StatefulWidget {
  const TasksPageGraphism({Key? key}) : super(key: key);

  @override
  _TasksPageGraphismState createState() => _TasksPageGraphismState();
}

class _TasksPageGraphismState extends State<TasksPageGraphism> {
  /// Setting up the date displayed on top of the page
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat(
      'MMMEd'); //   DateFormat.yMMMMd('fr'); //DateFormat('yyyy-MM-dd');

  String getDate() {
    return formatter.format(now);
  }

  ///setting up the Stream we get the news of the colocation from
  ///
  Stream<QuerySnapshot>? _tasks;
  String? idColoc;
  String? userUIDadd;

  void setId() async {
    String userUID = await AuthService().getUser();
    String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc();
    print('prefid : ' + prefidcoloc);
    Stream<QuerySnapshot> prefquerytasks =
        await FirebaseFirestore.instance
        .collection('colocs/' + prefidcoloc + '/tasks')
     //   .where('name', isEqualTo: 'Ivo')
        .orderBy("deadline", descending: true)
        .snapshots();
    setState(() {
      _tasks = prefquerytasks;
      idColoc = prefidcoloc;
      userUIDadd = userUID;
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
            floatingActionButton: FloatingActionButton(onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TaskForm()));
            }),
            drawer: HomeDrawer(),
            body: StreamBuilder<QuerySnapshot>(
                stream: _tasks,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting ||
                      (idColoc == null)) {
                    return const Text("Loading");
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    print(this.idColoc);
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
                                      getDate(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.2 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width),
                                      child: Row(children: <Widget>[
                                        Column(
                                          children: const [
                                             Text(
                                             '9',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 26),
                                            ),
                                            Text(
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
                                                      fontSize: 35,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 25.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                snapshot.data!.size.toString(),
                                                style: const TextStyle (
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 26),
                                              ),
                                              const Text(
                                                'au total !',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
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
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    color: Color(0xF615354C),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: StreamProvider<List<Task>?>.value(
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
                                              '  Vos tâches en attente ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Padding(
                                                key: UniqueKey(),
                                                padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                )),
                                            Flexible(
                                              child: ListView(
                                                children: snapshot.data!.docs
                                                    .map<Widget>(
                                                        (DocumentSnapshot
                                                            document) {
                                                  Map<String, dynamic> data =
                                                      document.data()! as Map<
                                                          String, dynamic>;
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: ItemTasksv3(idColoc,
                                                        Task.fromJSON(data)),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            Padding(
                                                key: UniqueKey(),
                                                padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  ///fin Stream Provider
                                );
                              },
                            ),
                          ),
                        ),
                      ]);
                    });
                  }
                  return Container();
                })

            ///Fin material app

            ));
  }
}
