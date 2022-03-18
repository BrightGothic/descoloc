import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/memories/story.dart';
import 'package:descoloc/services/shared_preferences.dart';


class StoriesCollectionServices {


  StoriesCollectionServices();


  ///Manage Stories in Firestore

  //collection reference

  final FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;

  ///Add and modify a groceries article
  ///
  Future updateStoriesData(String id, String name, Timestamp created, Timestamp modified) async {
    String? coloc = await ManipulateSharedPreferences().getIdColoc(); //get the current coloc uid

    //final user = await AuthService().getUser();
  return await firebaseInstance
      .collection('colocs/'+coloc+'/stories')
      .doc(id)
      .set({
  'id' : id,
  'name' : name,
  'created' : created,
  'modified' : modified,
  });

  }


  ///Add and modify a stories list
  Future updateStoriesListData(String id, String name, Timestamp created, Timestamp modified) async {
    String coloc = await ManipulateSharedPreferences().getIdColoc(); //get the current coloc uid

    return await firebaseInstance.collection('colocs/'+coloc+'/stories').doc(id).set({
    'id' : id,
    'name' : name,
    'created' : created,
    'modified' : modified,
  });

  }

  //stories from snapshot

  Story storiesFromSnapshot(DocumentSnapshot snapshot) {
  var data = snapshot.data() as Map<String, dynamic >;
  data as DocumentSnapshot;
 // if (data == null) throw Exception("Stories not found");
  return Story.fromJSON(data);
  }

  //Stories list from snapshot
  ///A TRAVAILLER, ERREUR INATTENDUE !!
  ///
  ///
  ///
  List<Story>? _storiesListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.docs.map((doc){
  return Story(
  id : doc.get('id'),
  name : doc.get('name') ?? '',
  created : doc.get('created') ?? DateTime.now(),
  modified : doc.get('modified') ?? DateTime.now(),
  );
  }).toList();
  }

  //get stories stream
  Future<Stream<Story?>> get stories async {
    String coloc = await ManipulateSharedPreferences().getIdColoc(); //get the current coloc uid

    return firebaseInstance.collection('colocs/'+'seculoc'+'/stories').doc('storieslist').snapshots().map(storiesFromSnapshot);
  }

  /// A RETRAVAILLER, ERREUR INATTENDUE

  //get stories list stream
  Stream<List<Story>?> get storieslist  {

  return firebaseInstance.collection('colocs/'+'seculoc'+'/stories/').snapshots().map(_storiesListFromSnapshot);

  }

  }