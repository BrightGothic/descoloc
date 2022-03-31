import 'package:cloud_firestore/cloud_firestore.dart';

class ColocataireController {

  Future<void> doesTheColocataireExists(String uid) async {
    final CollectionReference colocataireCollection = await FirebaseFirestore.instance.collection('users');

  }
}