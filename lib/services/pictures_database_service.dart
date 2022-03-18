import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/memories/picture.dart';
import 'package:descoloc/models/task.dart';
import 'package:descoloc/services/shared_preferences.dart';

class PictureServices{

  PictureServices();



  ///Manage Picture in Firestore

  //collection reference



  Future updatePictureData(String id,  String name,  String filePath, String comment, Timestamp? created) async {
    String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc(); //get the current coloc uid
    String? prefidstory = await ManipulateSharedPreferences().getIdStory(); //get the current coloc uid

    final CollectionReference picturesCollection = await FirebaseFirestore.instance.collection('colocs/'+prefidcoloc+'/stories/$prefidstory/content');

    return await picturesCollection.doc().set({
      'id' : id,
      "name" : name,
      "filePath" : filePath,
      "comment" : comment,
      "created" : created,

    });

  }

  //Pictures from snapshot

  Picture _pictureFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    data as DocumentSnapshot;
    if (data == null) throw Exception("task not found");
    return Picture(
      id : (data)['id'],
      name : (data)['name'],
      filePath : (data)['filePath'] ?? 0,
      comment : (data)['comment'] ?? 0,
      created : (data)['created'] ?? DateTime.now(),
    );
  }

  //picture list from snapshot

  List<Picture>? _pictureListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Picture(
          id : doc.get('id') ?? '',
          name :doc.get('name') ?? '',
          filePath :doc.get('filePath') ?? '',
          comment :doc.get('comment') ?? '',
          created :doc.get('created') ?? DateTime.now(),
      );
    }).toList();
  }

  //get picture stream
  Future<Stream<Picture?>> get picture async {
    String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc(); //get the current coloc uid
    String? prefidstory = await ManipulateSharedPreferences().getIdStory(); //get the current coloc uid
    final CollectionReference pictureCollection = FirebaseFirestore.instance.collection('colocs/'+prefidcoloc+'/stories/$prefidstory/content');
    return pictureCollection.doc('uid').snapshots().map(_pictureFromSnapshot);
  }

  //get taskS stream
  Stream<List<Picture>?> get pictures {
    final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('colocs/'+'seculoc'+'/stories/');
    return tasksCollection.snapshots().map(_pictureListFromSnapshot);
  }
}