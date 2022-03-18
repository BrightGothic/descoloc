import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/godsama/models/colocataires.dart';
import 'package:descoloc/models/colocataire.dart';

class GsColocServices{

  Future<List<Colocataire>> getPictures(String idstories, String idColoc) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    List<Colocataire> retVal = List.empty(growable: true);

    try {
      QuerySnapshot<Map<String, dynamic>> query = await _firestore
          .collection("colocs")
          .doc(idColoc)
          .collection("colocataires")
          .get();

      query.docs.forEach((element) {
        retVal.add(Colocataire.fromDocumentSnapshot(element));
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }

}