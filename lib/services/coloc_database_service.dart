import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/coloc.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ColocServices {

  ColocServices();


  ///Manage Colocs in Firestore

  //collection reference
  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference colocCollection = FirebaseFirestore.instance.collection('colocs');


  ///Ajouter une coloc

  @override
  Future<void> addColoc(String namecoloc, String uid) async {
    print(namecoloc);
    // Call the coloc's CollectionReference to add a new coloc
    final ref = colocCollection.doc();
    return ref
        .set({
      'name' : namecoloc,
      'id' : ref.id,
      'membres' : [uid],
      'created_by' : uid,

    })
        .then((value) => print("Coloc Added"))
        .catchError((error) => print("Failed to add coloc: $error"));
  }


  //coloc from snapshot

  Coloc _colocFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    data as DocumentSnapshot;
    if (data == null) throw Exception("task not found");
    return Coloc(
        (data)['name'],
        (data)['id'],
        (data)['membres'],
        (data)['created_by']
    );
  }

  ///Delete Coloc
  ///

  Future<bool> deleteColoc(String id) async {
   try {
     await colocCollection.doc(id).delete();
     return true;
   }catch(e){
     return false;
   }
  }

  //coloc list from snapshot

  List<Coloc>? _colocListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Coloc(
          doc.get('name') ?? '',
          doc.get('id') ?? '',
          doc.get('membres') ?? [''],
          doc.get('created_by') ?? '',

      );
    }).toList();
  }

  //get coloc stream
  Stream<Coloc?> get coloc{
    return colocCollection.doc().snapshots().map(_colocFromSnapshot);
  }

  //get colocs stream
  Stream<List<Coloc>?> get colocs{
    return colocCollection.snapshots().map(_colocListFromSnapshot);
  }

}

