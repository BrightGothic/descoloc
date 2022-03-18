import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String id;
  String user;
  String type;
  String namenews;
  Timestamp date;
  String reward;

  News(this.id, this.user, this.type, this.namenews, this.date, this.reward);

  //Obtain a News from a JSON data
  factory News.fromJSON(Map<String, dynamic> j) => News(
      j['id'],
      j['user'],
      j['type'],
      j['namenews'],
      j['date'],
      j['reward']);

  //Obtain a JSON file from a News class
  Map<String, dynamic> toMap() =>
      {"id": id, "name": user, "type": type, "namenews": namenews, "date": date, "reward" : reward};
}
