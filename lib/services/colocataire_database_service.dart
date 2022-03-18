import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/colocataire.dart';

class ColocataireServices{
  final String? idColoc;
  ColocataireServices({required this.idColoc});


  ///Manage Tasks in Firestore

  //collection reference



  Future updateColocataireData(String uid,  String name, String pseudo, int score, int tasksNumber, Timestamp dayOfAdd) async {

    final CollectionReference colocataireCollection = await FirebaseFirestore.instance.collection('colocs/'+idColoc!+'/colocataires');

    await FirebaseFirestore.instance.collection('colocs').doc(idColoc).update({'membres':FieldValue.arrayUnion([uid])});

    final ref = colocataireCollection.doc();

    return await ref.set({
      'uid' : uid,
      'name' : name,
      'pseudo' : pseudo,
      'score' : score,
      'tasksNumber' : tasksNumber,
      'dayOfAdd' : dayOfAdd,
      'idcolocataire' : ref.id
    });

  }

  Future deleteColocataireFromColoc(Colocataire colocataire) async {

   await FirebaseFirestore.instance
        .collection('colocs/'+idColoc!+'/colocataires').doc(colocataire.uid).delete();



  }
  Future deleteColocataireFromMembresColoc(Colocataire colocataire) async {



    await FirebaseFirestore.instance.collection('colocs').doc(idColoc).update({'membres':FieldValue.arrayRemove([colocataire.uid])});


  }

  //colocataire from snapshot

  Colocataire _colocataireFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    data as DocumentSnapshot;
    if (data == null) throw Exception("task not found");
    return Colocataire(
      uid :(data)['uid'],
      name : (data)['name'],
      pseudo :(data)['pseudo'] ?? '',
      score : (data)['score'] ?? 0,
      tasksNumber : (data)['tasksNumber'] ?? 0,
      dayOfAdd : (data)['dayOfAdd'] ?? Timestamp.now(),
      idcolocataire :(data)['idcolocataire'] ?? '',

    );
  }

  //colocataire list from snapshot

  List<Colocataire>? _colocataireListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Colocataire(
        uid : doc.get('uid') ?? '',
        name : doc.get('name') ?? '',
        pseudo : doc.get('pseudo') ?? '',
        score : doc.get('score') ?? 0,
        tasksNumber : doc.get('tasksNumber') ?? 0,
        dayOfAdd : doc.get('dayOfAdd') ?? Timestamp.now(),
        idcolocataire :doc.get('idcolocataire') ?? '',
      );
    }).toList();
  }

  //get colocataire stream
  Stream<Colocataire?> get colocataire{
    final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('colocs/'+idColoc!+'/colocataires');
    return tasksCollection.doc('uid').snapshots().map(_colocataireFromSnapshot);
  }

  //get colocataireS stream
  Stream<QuerySnapshot> get colocataires{
    final CollectionReference colocataireCollection = FirebaseFirestore.instance.collection('colocs/'+idColoc!+'/colocataires');
    return colocataireCollection.orderBy('score', descending: true).snapshots();
  }
}