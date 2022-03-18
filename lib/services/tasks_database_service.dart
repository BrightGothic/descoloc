import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/colocataire.dart';
import 'package:descoloc/models/task.dart';
import 'package:descoloc/services/news_database_service.dart';

import 'auth.dart';

class TaskServices{
  final String? idColoc;
  TaskServices({required this.idColoc});


  ///Manage Tasks in Firestore

  //collection reference



  Future updateTaskData(String name,  String property,  int reward, String addedBy, bool done, Timestamp dayOfAdd, Timestamp? deadline) async {
    String userUID = await AuthService().getUser();

    final CollectionReference tasksCollection = await FirebaseFirestore.instance.collection('colocs/'+idColoc!+'/tasks');
    final ref = tasksCollection.doc();
    return await ref.set({
      'id' : ref.id,
      'name' : name,
      'property' : property,
      'reward' : reward,
      'addedBy' : addedBy,
      'done' : done,
      'dayOfAdd' : dayOfAdd,
      'deadline' : deadline,
      'achievedBy' : userUID
    });

  }

  Future isTaskDone(Task task,Colocataire colocataire, bool done) async {
    final CollectionReference tasksCollection = await FirebaseFirestore.instance.collection('colocs').doc(idColoc).collection('tasks');
    final CollectionReference colocataireCollection = await FirebaseFirestore.instance.collection('colocs').doc(idColoc).collection('colocataires');

    if(done){
      await colocataireCollection.doc(colocataire.idcolocataire).update({"score" : FieldValue.increment(task.reward),"tasksNumber" : FieldValue.increment(1) });
      String userUID = await AuthService().getUser();

      await NewsServices(idColoc: idColoc).updateNewsData(colocataire.name, 'task', task.name, Timestamp.now(), task.reward.toString());

      return await tasksCollection.doc(task.id).update({
        'done' : done,
        'achievedBy' : userUID,

      });
    }else{
      await colocataireCollection.doc(colocataire.idcolocataire).update({"score" : FieldValue.increment(-1*task.reward),"tasksNumber" : FieldValue.increment(-1) });
      String userUID = await AuthService().getUser();


      return await tasksCollection.doc(task.id).update({
        'done' : done,
        'achievedBy' : userUID,

      });
    }


  }


  //task from snapshot

  Task _taskFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    data as DocumentSnapshot;
    if (data == null) throw Exception("task not found");
    return Task(
        (data)['id'] ?? 'Id Task manquant',
        (data)['name'] ?? '',
        (data)['property'],
        (data)['reward'] ?? 0,
        (data)['reward'] ?? 0,
        (data)['reward'] ?? 0,
        (data)['reward'] ?? 0,
        (data)['reward'] ?? 0,
        (data)['achievedBy'] ?? ''
    );
  }

  //task list from snapshot

  List<Task>? _taskListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Task(
          doc.get('id') ?? 'idTask manquant',
          doc.get('name') ?? '',
          doc.get('property') ?? '',
          doc.get('reward') ?? 0,
          doc.get('addedBy') ?? 0,
          doc.get('done') ?? false,
          doc.get('dayOfAdd') ?? 0,
          doc.get('deadline') ?? 0,
          doc.get('achievedBy') ?? ''
      );
    }).toList();
  }

  //get task stream
  Stream<Task?> get task{
    final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('colocs/'+idColoc!+'/tasks');
    return tasksCollection.doc('uid').snapshots().map(_taskFromSnapshot);
  }

  //get taskS stream
  Stream<List<Task>?> get tasks{
    final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('colocs/'+idColoc!+'/tasks');
    return tasksCollection.snapshots().map(_taskListFromSnapshot);
  }

  //Delete Item
  Future<bool> deleteTask(Task task, Colocataire colocataire) async {
    final FirebaseFirestore FirebaseInstance = FirebaseFirestore.instance;
    final CollectionReference colocataireCollection = await FirebaseFirestore.instance.collection('colocs').doc(idColoc).collection('colocataires');

    try {
      await colocataireCollection.doc(colocataire.idcolocataire).update({"score" : FieldValue.increment(-1*task.reward),"tasksNumber" : FieldValue.increment(-1) });

      await FirebaseInstance
          .collection('colocs/' + idColoc! + '/tasks')
          .doc(task.id).delete(); //remplacer name par id

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}