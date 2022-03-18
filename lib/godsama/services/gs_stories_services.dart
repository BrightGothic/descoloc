import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/godsama/models/stories.dart';

class GsStoriesServices {

  void updateStoriesData(String idColoc, String id,  String name, Timestamp created, Timestamp? modified) async {

    final CollectionReference picturesCollection = FirebaseFirestore.instance.collection('colocs/$idColoc/stories/');

    return await picturesCollection.doc().set({
      'id' : id,
      "name" : name,
      "created" : created,
      "modified" : modified,

    });

  }

  Future<List<Stories>> getStories(String idColoc) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    List<Stories> retVal = List.empty(growable: true);

    try {
      QuerySnapshot<Map<String, dynamic>> query = await _firestore
          .collection("colocs")
          .doc(idColoc)
          .collection("stories")
         // .orderBy("created", descending: true)
          .get();

      query.docs.forEach((element) {
        retVal.add(Stories.fromDocumentSnapshot(element));
      });
    } catch (e) {
      print(e);
    }
    return retVal;
}

}