import 'package:cloud_firestore/cloud_firestore.dart';

///This class works along the page "screens/authenticate/signin.dart"
///It is the skeleton of the requests about users content with Cloud Firestore

class Colocataires {
  String uid, name, pseudo;
  int score, tasksNumber;
  Timestamp dayOfAdd;
  Colocataires({
    required this.uid,
    required this.name,
    required this.pseudo,
    required this.score,
    required this.tasksNumber,
    required this.dayOfAdd});


  //Obtain a User from a JSON data
  factory Colocataires.fromJSON(Map<String, dynamic> j) => Colocataires(
    uid : j['uid'] ?? '',
    name: j['name'] ?? '',
    pseudo: j['pseudo'] ?? '',
    score: j['score'] ?? 0,
    tasksNumber: j['tasksNumber'] ?? 0,
    dayOfAdd: j['dayOfAdd'] ?? Timestamp.now(),
  );

  factory Colocataires.fromDocumentSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) => Colocataires(
      uid : doc.id,
      name : doc["name"] ?? '',
      pseudo:  doc["filePath"],
      score: doc["score"],
      tasksNumber: doc["tasksNumber"],
      dayOfAdd : doc["dayOfAdd"]
  );
  //Obtain a JSON file from a User class
  Map<String, dynamic> toMap() => {
    "uid" : uid,
    "name" : name,
    "pseudo" : pseudo,
    "score" : score,
    "tasksNumber" : tasksNumber,
    "dayOfAdd": dayOfAdd
  };
}