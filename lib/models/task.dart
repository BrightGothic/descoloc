import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  String id;
  String name;
  String property;
  int reward;
  String addedBy;  ///The UID of the user who add the task
  bool done;   ///The UID of the user who have to do the task
  Timestamp dayOfAdd;
  Timestamp? deadline;
  String? achievedBy;

 Task(this.id, this.name, this.property, this.reward, this.addedBy,this.done, this.dayOfAdd, this.deadline, this.achievedBy);

  //Obtain a Groceries from a JSON data
  factory Task.fromJSON(Map<String, dynamic> j) => Task(
      j['id'],
      j['name'],
      j['property'],
      j['reward'],
      j['addedBy'],
      j['done'],
      j['dayOfAdd'],
      j['deadline'],
      j['achievedBy']
  );

  //Obtain a JSON file from a Groceries class
  Map<String, dynamic> toMap() =>
      {"id" : id, "name": name,"property": property, "reward": reward, "addedBy": addedBy, "done":done, "dayOfAdd" : dayOfAdd, "deadline" : deadline, "achievedBy" : achievedBy};
}

