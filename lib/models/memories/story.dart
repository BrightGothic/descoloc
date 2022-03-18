class Story{
  String id, name;
  DateTime created, modified;
  Story({required this.id,required this.name, required this.created,required this.modified});


  //Obtain a Story from a JSON data
  factory Story.fromJSON(Map<String, dynamic> j) => Story(
      id : j['id'],
      name: j['name'],
      created: j['created'].toDate(),
      modified: j['modified'].toDate(),
  );

  //Obtain a JSON file from a Story class
  Map<String, dynamic> toMap() => {
    "id" : id,
    "name" : name,
    "created" : created,
    "modified" : modified
  };
}