class Coloc {

  final String name;
  final String id;
  final List<String> members;
  final String created_by;


  Coloc(this.name, this.id, this.members, this.created_by );

  //Obtain a Coloc from a JSON data
  factory Coloc.fromJSON(Map<String, dynamic> j) => Coloc(j['name'], j['id'], j['members'], j['created_by']);

  //Obtain a JSON file from a Coloc class
  Map<String, dynamic> toMap() => {
    "name" : name,
    "id" : id,
    "members" : members,
    "created_by" : created_by
  };
}