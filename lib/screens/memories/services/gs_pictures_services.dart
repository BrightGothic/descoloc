import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/screens/memories/models/pictures.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GsPicturesServices{

  void updatePictureData(String idColoc, String idStories, String id,  String name,  String filePath, String comment, Timestamp? created) async {

    final CollectionReference picturesCollection = FirebaseFirestore.instance.collection('colocs/$idColoc/stories/$idStories/memories');

    return await picturesCollection.doc(id).set({
      'id' : id,
      "name" : name,
      "filePath" : filePath,
      "comment" : comment,
      "created" : created,

    });


  }

  Future<List<Pictures>> getPictures(String idstories, String idColoc) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    List<Pictures> retVal = List.empty(growable: true);

    try {
      QuerySnapshot<Map<String, dynamic>> query = await _firestore
          .collection("colocs")
          .doc(idColoc)
          .collection("stories")
          .doc(idstories)
          .collection("memories")
      // .orderBy("created", descending: true)
          .get();

      query.docs.forEach((element) {
        retVal.add(Pictures.fromDocumentSnapshot(element));
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }


  //Delete Item
  Future<bool> deletePicture(String idColoc, String idStories, Pictures pictures) async {
    final FirebaseFirestore FirebaseInstance = FirebaseFirestore.instance;
    print('URL : ' + pictures.filePath);
    try {
      await FirebaseInstance
          .collection('colocs/'+idColoc+'/stories')
          .doc(idStories)
          .collection('memories').doc(pictures.id).delete();

      await FirebaseStorage.instance.refFromURL(pictures.filePath).delete();
      print('Supprimé !');
      return true;
    }catch(e){
      print (e);
      return false;
    }
  }
}