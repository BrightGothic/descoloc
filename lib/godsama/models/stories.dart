import 'package:cloud_firestore/cloud_firestore.dart';

class Stories{
  String id, name;
  Timestamp created, modified;
  Stories({required this.id,required this.name, required this.created,required this.modified});


  //Obtain a Story from a JSON data
  factory Stories.fromJSON(Map<String, dynamic> j) => Stories(
    id : j['id'],
    name: j['name'],
    created: j['created'],
    modified: j['modified'],
  );

  factory Stories.fromDocumentSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) => Stories(
    id : doc.id,
    name : doc["name"] ?? '',
    created:  doc["created"] ?? Timestamp.now(),
    modified: doc["modified"] ?? Timestamp.now(),
  );

  //Obtain a JSON file from a Story class
  Map<String, dynamic> toMap() => {
    "id" : id,
    "name" : name,
    "created" : created,
    "modified" : modified
  };
}