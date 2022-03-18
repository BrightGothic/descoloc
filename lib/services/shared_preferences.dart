import 'package:shared_preferences/shared_preferences.dart';

class ManipulateSharedPreferences {

  getalreadyVisited() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
  }

  setalreadyVisited(bool value) async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    preferences.setBool('alreadyVisited', value);
  }


  getColocIDSP() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    String? CID = preferences.getString('CID');
    return CID;
  }

  setColocIDSP(String CID) async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    preferences.setString('CID', CID);
  }

  deletePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<String> getIdColoc() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    String idColoc = preferences.getString('idColoc')  ?? 'Erreur dans le get, le idcoloc est null dans SharedPreferences';
    return idColoc;
  }

  setIdColoc(String value) async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    preferences.setString('idColoc', value);
  }

  Future<String> getIdStory() async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    String idStory = preferences.getString('idStory')  ?? 'Erreur dans le get, le idcoloc est null dans SharedPreferences';
    return idStory;
  }

  setIdStory(String value) async {
    SharedPreferences preferences = await  SharedPreferences.getInstance();
    preferences.setString('idStory', value);
  }
}