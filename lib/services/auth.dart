import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:descoloc/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Methods about connexion / Disconnection from the app
  ///
  ///
  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register email and password
  Future registerWithEmailAndPassword(String email, String name, String password, String pseudo) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      ///get the current user data (very important)
      UserInApp userInApp =
      UserInApp(uid: user!.uid, name: name, pseudo: pseudo);

      //create a new document for the user
      await updateUserData(userInApp);

      return userfromFirebase(user);
    } catch (e) {
      print("Erreur d'inscription" + e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// Method to create or modify a user
  ///
  ///

  // Set the data of a user
  Future updateUserData(UserInApp user) async {
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    try {
      await usersCollection.doc(user.uid).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Methods about getting the user information
  ///
  ///
  //create user object based on Firebase user
  UserInApp? userfromFirebase(User? user) {
    if (user != null) {
      return UserInApp(uid: user.uid, name: "Oups pas bon", pseudo: "");
    } else {
      return null;
    }
  }

  //Get UID from the Firebase user  --- display on profile
  String idfromFirebase(User? user) {
    if (user != null) {
      return user.uid;
    } else {
      print(
          'The user doesn t exist (see auth.dart idfromFirebase() for further information)');
      return '';
    }
  }

  // Get the data about a User -- Display in Profile
  Future getUserfromId(String id) async {
    final CollectionReference usersCollection =
    FirebaseFirestore.instance.collection('users');

    try {
      final data = await usersCollection.doc(id).get();
      final user = UserInApp.fromJSON(data.data() as Map<String, dynamic>);
      return user;
    } catch (e) {
      print('Error in get user, try failed');
    }
  }

  /// Methods about getting the Stream
  ///
  ///

  //auth change user stream
  Stream<UserInApp?> get userStream {
    return _auth.authStateChanges().map(userfromFirebase);
  }

  /// Methods that must have a use but idk I forgot it

  // get user from Firebase
  Future<User?> get user async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }

  //get the User
  Future<String> getUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = await _auth.currentUser;
    return user!.uid;
  }

  Future<String> getName() async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String? user = await _auth.currentUser!.uid;
    return user;
  }

  Future<bool> doesPseudoExist(String pseudoRegister) async {
    try {
      final pseudoCollection = FirebaseFirestore.instance.collection('users');
      final query = await pseudoCollection.where('pseudo', isEqualTo: pseudoRegister)
          .get()
          .then((value) {
          print('value.docs.isNotEmpty ' + value.docs.isNotEmpty.toString());
          return value.docs.isNotEmpty; //return true if the pseudo has already been chosen by a user
       });
      return query;
    }catch(e){
      print('FCKING ERROR  : ' + e.toString());
      return true;
    }
  }
}
