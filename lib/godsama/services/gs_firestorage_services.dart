import 'dart:core';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class GsFirestorageServices {

  GsFirestorageServices();
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  ///Upload the file taking his name and desired path in entry
  Future<String> uploadFile(String filePath, String idColoc, String idStories, String fileName) async {
    File file = File(filePath);
    try {
      await storage.ref('$idColoc/stories/$idStories/pictures/$fileName').putFile(file);
      firebase_storage.TaskSnapshot snap = await storage.ref('$idColoc/stories/$idStories/pictures/$fileName').putFile(file);
      String downloadURL = await snap.ref.getDownloadURL();
      return downloadURL;
    } on firebase_core.FirebaseException catch (e) {
      print(e);
      return 'error';
    }
  }

  ///Load the image from the Internet
  Future<String> downloadURL(String idColoc, String idStory, String pictureName) async {
    try{
      String downloadURL = await storage.ref('$idColoc/stories/$idStory/pictures/$pictureName').getDownloadURL();
      return downloadURL;
    }catch(e){
      print('ON A UN PB ');
      print(e);
    }
    return '';
  }

}