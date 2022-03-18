import 'package:cloud_firestore/cloud_firestore.dart';

class Picture{
  String id, name, filePath, comment;
  Timestamp created;
  Picture({required this.id,required this.name,required this.filePath, required this.comment, required this.created});


  //Obtain a Picture from a JSON data
  factory Picture.fromJSON(Map<String, dynamic> j) => Picture(
    id : j['id'],
    name: j['name'],
    filePath: j['filePath'],
    comment: j['comment'],
    created: j['created'],
  );

  //Obtain a JSON file from a Picture class
  Map<String, dynamic> toMap() => {
    "id" : id,
    "name" : name,
    "filePath" : filePath,
    "comment" : comment,
    "created" : created,
  };
}