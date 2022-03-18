import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/news.dart';

class NewsServices{
  final String? idColoc;
  NewsServices({required this.idColoc});


  ///Manage Tasks in Firestore

  //collection reference



  Future updateNewsData(String user,  String type,  String namenews, Timestamp date, String reward) async {

    final CollectionReference tasksCollection = await FirebaseFirestore.instance.collection('colocs/'+idColoc!+'/news');
    final ref = tasksCollection.doc();
    return await ref.set({
      'id' : ref.id,
      'user' : user,
      'type' : type,
      'namenews' : namenews,
      'date':date,
      'reward' : reward

    });

  }


  //task from snapshot

  News _newsFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    data as DocumentSnapshot;
    if (data == null) throw Exception("task not found");
    return News(
        (data)['id'] ?? 0,
        (data)['user'] ?? 'random',
        (data)['type'] ?? 'task',
        (data)['namenews'] ?? 'something',
        (data)['date'] ?? Timestamp.now(),
        (data)['reward'] ?? '0',

    );
  }

  //task list from snapshot

  List<News>? _newsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return News(
          doc.get('id') ?? 0,
          doc.get('user') ?? '',
          doc.get('type') ?? '',
          doc.get('namenews') ?? '',
          doc.get('date') ?? Timestamp.now(),
          doc.get('reward') ?? '0'
      );
    }).toList();
  }

  //get task stream
  Stream<News?> get news{
    final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('colocs/'+idColoc!+'/news');
    return tasksCollection.doc('uid').snapshots().map(_newsFromSnapshot);
  }

  //get News list stream
  Stream<List<News>?> get newslist{
    final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('colocs/'+idColoc!+'/news');
    return tasksCollection.limit(3).orderBy('date', descending: true).snapshots().map(_newsListFromSnapshot);
  }
}