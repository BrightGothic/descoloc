import 'package:cloud_firestore/cloud_firestore.dart';

///This class works along the page "screens/authenticate/signin.dart"
///It is the skeleton of the requests about users content with Cloud Firestore

class Colocataire {
  String uid, name, pseudo, idcolocataire;
  int score, tasksNumber;
  Timestamp dayOfAdd;
  Colocataire({
    required this.idcolocataire,
    required this.uid,
    required this.name,
    required this.pseudo,
    required this.score,
    required this.tasksNumber,
    required this.dayOfAdd});


  //Obtain a User from a JSON data
  factory Colocataire.fromJSON(Map<String, dynamic> j) => Colocataire(
      uid : j['uid'],
      name: j['name'],
      pseudo: j['pseudo'],
      score: j['score'],
      tasksNumber: j['tasksNumber'],
      dayOfAdd: j['dayOfAdd'],
      idcolocataire: j['idcolocataire'],

  );

  factory Colocataire.fromDocumentSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) => Colocataire(
      uid : doc["uid"] ?? '',
      name : doc["name"] ?? '',
      pseudo:  doc["pseudo"],
      score: doc["score"],
      tasksNumber: doc["tasksNumber"],
      dayOfAdd : doc["dayOfAdd"],
      idcolocataire : doc["idcolocataire"] ?? ''
  );

  //Obtain a JSON file from a User class
  Map<String, dynamic> toMap() => {
    "uid" : uid,
    "name" : name,
    "pseudo" : pseudo,
    "score" : score,
    "tasksNumber" : tasksNumber,
    "dayOfAdd": dayOfAdd,
    "idcolocataire" : idcolocataire
  };
}