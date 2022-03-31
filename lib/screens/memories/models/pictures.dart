import 'package:cloud_firestore/cloud_firestore.dart';

class Pictures{
  String id, name, filePath, comment;
  Timestamp created;
  Pictures({required this.id,required this.name, required this.filePath,required this.comment, required this.created});


  //Obtain a Story from a JSON data
  factory Pictures.fromJSON(Map<String, dynamic> j) => Pictures(
    id : j['id'],
    name: j['name'],
    filePath: j['filePath'],
    comment: j['comment'],
    created: j['created'],
  );

  factory Pictures.fromDocumentSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) => Pictures(
      id : doc.id,
      name : doc["name"] ?? '',
      filePath:  doc["filePath"],
      comment: doc["comment"],
      created : doc["created"]
  );

  //Obtain a JSON file from a Story class
  Map<String, dynamic> toMap() => {
    "id" : id,
    "name" : name,
    "filePath" : filePath,
    "comment" : comment,
    "created" : created,
  };
}