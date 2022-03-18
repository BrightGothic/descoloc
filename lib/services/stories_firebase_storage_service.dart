import 'dart:core';
import 'dart:io';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;


  ///Upload the file taking his name and desired path in entry
  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc(); //get the current coloc uid
    try {
      await storage.ref('$prefidcoloc/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
/// Gives the list of the files stored in the chosen folder
  Future<firebase_storage.ListResult> listFiles() async {
    String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc(); //get the current coloc uid
    firebase_storage.ListResult results =
        await storage.ref('$prefidcoloc/').listAll();
    results.items.forEach((firebase_storage.Reference ref) {
      print('Found the file $ref');
    });
    return results;
  }

  Future<String> downloadURL(String folderPath, String image) async {
try{
  String? prefidcoloc = await ManipulateSharedPreferences().getIdColoc(); //get the current coloc uid
  String downloadURL = await storage.ref('$prefidcoloc/' + image).getDownloadURL();
  return downloadURL;
}catch(e){
  print('ON A UN PB ');
  print(e);
}
return '';
  }
}
