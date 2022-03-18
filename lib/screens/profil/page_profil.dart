import 'dart:ui';
import 'package:descoloc/classes/class_wrapper_yt.dart';
import 'package:descoloc/models/user.dart';
import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:descoloc/services/auth.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../handmadewidgets/bordel_a_virer_asap/widget_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserInApp? userInApp;

  AuthService auth = AuthService();

  Future<bool> getUser() async {
    User? user = await auth.user;
    String userUID = AuthService().idfromFirebase(user);
    final userfinal = await AuthService().getUserfromId(userUID);
    setState(() {
      userInApp = userfinal as UserInApp;
    });
    return true;
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: HomeDrawer(),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.indigoAccent, Colors.lightBlueAccent],
            )),
          ),
          FutureBuilder<void>(
              future: getUser(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0.06 * MediaQuery.of(context).size.height,),
                          ),
                          Center(
                            key: UniqueKey(),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.account_circle, size: 100, color: Colors.white,),
                            ),
                          ),
                          Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  key: UniqueKey(),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userInApp!.uid,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  key: UniqueKey(),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userInApp!.pseudo,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color:Colors.indigoAccent,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              width : 0.9 * MediaQuery.of(context).size.width,

                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: SizedBox(
                                  height : 0.6 * MediaQuery.of(context).size.height,
                                  width : 0.9 * MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Padding(
                                          key: UniqueKey(),
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text("S abonner"),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Abonnes(),
                                            Abonnements(),
                                            Points(),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            key: UniqueKey(),
                                            padding: const EdgeInsets.all(10.0),
                                          ),
                                          Padding(
                                            key: UniqueKey(),
                                            padding: const EdgeInsets.all(10.0),
                                            child: const Text('A propos',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: RichText(
                                              text: TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'A propos',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Center(
                                        child: Column(
                                          children: [
                                            Container(
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty.all(
                                                                Colors.white54)),
                                                    onPressed: () async {
                                                      await _auth
                                                          .signOut(); //The user is disconnected from the app
                                                      ManipulateSharedPreferences()
                                                          .deletePreferences(); // delete the SharedPreferences of the user locally hosted on the device
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Wrapper()));
                                                    },
                                                    child: Text('Déconnexion'))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ];
                } else {
                  children = [Center(child: Text('Loading...'))];
                }
                return Center(
                  child: Column(
                    children: children,
                  ),
                );
              }),
        ],
      ),
      extendBody: true,
    );
  }
}
