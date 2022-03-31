import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/handmadewidgets/page_tasks_list/new_task_list_item_graphic/graphic_widget_task.dart';
import 'package:descoloc/handmadewidgets/page_tasks_list/widget_task.dart';
import 'package:descoloc/models/task.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///This class is deprecated. We now return the ListTile directly in Accueil() in order to simplify the Stream
///processes.
class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
//  final Stream<QuerySnapshot> tasks = FirebaseFirestore.instance.collection('tasks').snapshots();
  late final Stream<QuerySnapshot> _tasks;

  Future<void> setId() async {
    String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc();
    Stream<QuerySnapshot> prefquerytasks = FirebaseFirestore.instance
        .collection('colocs')
        .doc(prefidcoloc)
        .collection('tasks')
        .snapshots();
    setState(() {
      _tasks = prefquerytasks;
      print('On a initialisé dans SETID');
    });
  }

  @override
  void initState() {
    super.initState();
      setId().whenComplete(() => setState((){}));
      print('ON A INITIALISE');

  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _tasks,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
    {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }

      return ListView(
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return ItemTasksGraphic('',data['name'],data['property']);

        }).toList(),
      );
    },
    );
  }
}
