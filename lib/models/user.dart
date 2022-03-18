///This class works along the page "screens/authenticate/signin.dart"
///It is the skeleton of the requests about users content with Cloud Firestore

class UserInApp {
  String uid, name, pseudo;
  UserInApp({required this.uid,required this.name, required this.pseudo});


  //Obtain a User from a JSON data
  factory UserInApp.fromJSON(Map<String, dynamic> j) => UserInApp(uid : j['uid'], name: j['name'], pseudo: j['pseudo']);

  //Obtain a JSON file from a User class
  Map<String, dynamic> toMap() => {
    "uid" : uid,
    "name" : name,
    "pseudo" : pseudo
  };
}