import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/grocerie_article.dart';
import 'package:descoloc/services/auth.dart';


class GroceriesServices{
  final String? coloc;
  GroceriesServices(this.coloc);


  ///Manage Groceries in Firestore

  //collection reference

  final FirebaseFirestore FirebaseInstance = FirebaseFirestore.instance;

  ///Add and modify a groceries article
  ///
  Future updateGroceriesData(String id, String name, String brand, String quantity, String addedBy) async {
    final user = await AuthService().getUser();
    return await FirebaseInstance
        .collection('colocs/'+coloc!+'/groceries')
        .doc('grocerieslist')
        .collection('articles')
        .doc(id.toString())
        .set({
      'id' : id,
      'name' : name,
      'brand' : brand,
      'quantity' : quantity,
      'addedBy' : user,
    });

  }


  ///Add and modify a groceries list
  Future updateGroceriesListData(String id, String name, String brand, String quantity, String addedBy) async {
    return await FirebaseInstance.collection('colocs/'+coloc!+'/groceries').doc('grocerieslist').collection('articles').doc(id).set({
      'id' : id,
      'name' : name,
      'brand' : brand,
      'quantity' : quantity,
      'addedBy' : addedBy,
    });

  }

  //groceries from snapshot

  Groceries groceriesFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic >;
    data as DocumentSnapshot;
    if (data == null) throw Exception("Groceries not found");
    return Groceries.fromJSON(data);
  }

  //Groceries list from snapshot
///A TRAVAILLER, ERREUR INATTENDUE !!
  ///
  ///
  ///
 List<Groceries>? _groceriesListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Groceries(
          doc.get('id') ?? '',
          doc.get('name'),
          doc.get('brand') ?? '',
          doc.get('quantity') ?? 0,
          doc.get('addedBy') ?? 0,
      );
    }).toList();
  }

  //Delete Item
  Future<bool> deleteGrocery(String id) async {
    try {
      await FirebaseInstance
          .collection('colocs/'+coloc!+'/groceries')
          .doc('grocerieslist')
          .collection('articles').doc(id).delete();
      return true;
    }catch(e){
      return false;
    }
  }
  //get groceries stream
  Stream<Groceries?> get groceries{
    return FirebaseInstance.collection('colocs/'+coloc!+'/groceries').doc('grocerieslist').snapshots().map(groceriesFromSnapshot);
  }

  /// A RETRAVAILLER, ERREUR INATTENDUE

  //get groceries list stream
  Stream<List<Groceries>?> get grocerieslist {

      return FirebaseInstance.collection('colocs/'+coloc!+'/groceries/').doc('grocerieslist').collection('articles').snapshots().map(_groceriesListFromSnapshot);

  }

  //get groceries stream
  Stream<Groceries> get idIndex{
    return FirebaseInstance.collection('colocs/'+coloc!+'/groceries').doc('grocerieslist').snapshots().map(groceriesFromSnapshot);

  }

}