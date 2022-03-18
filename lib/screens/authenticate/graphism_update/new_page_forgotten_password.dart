import 'package:descoloc/screens/authenticate/graphism_update/new_page_signin.dart';
import 'package:descoloc/services/auth.dart';
import 'package:flutter/material.dart';

import '../authenticate.dart';

class ForgottenPasswordPage extends StatefulWidget {
  const ForgottenPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgottenPasswordPageState createState() => _ForgottenPasswordPageState();
}

class _ForgottenPasswordPageState extends State<ForgottenPasswordPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page de connexion',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                //colors: [Colors.purple, Colors.deepPurple],
                  colors: [Colors.indigoAccent, Colors.lightBlueAccent],
                  //colors: [Color(0xF615354C), Colors.lightBlueAccent],  Bleu foncé du center vers bleu clair
                  //colors: [Color(0xF625154C), Color(0xF615354C)], Dark,
                  //colors: [Color(0xF6363A3D), Color(0xF638383E)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              // border: BoxBorder()
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(50.0)),
                  Center(
                    child: ClipOval(
                      child: Icon(Icons.lock, size: 200, color: Colors.white,)
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      )),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.mail, color : Colors.white),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(),
                                  hintText: 'Adresse mail de récupération',
                                  hoverColor: Colors.white,
                                  fillColor: Colors.white,
                                  focusColor: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                        top: 25.0,
                      )),

                  const Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      )
                  ),
                  Center(
                    child: Builder(builder: (context) {
                      return Column(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if(_formKey.currentState!.validate()){
                                  _auth.resetPassword(email);
                                  final snackbar = const SnackBar(content: Text('Un mail vous a été envoyé'), duration: Duration(seconds: 2),);
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Authenticate()));
                                }
                              },
                              child: Container(
                                  width : 0.7 * MediaQuery.of(context).size.width,
                                  height : 0.08 * MediaQuery.of(context).size.height,
                                  decoration : BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(90)),
                                  ),
                                  child: Center(
                                      child: Text("Envoyer un mail à mon adresse mail",
                                        style: TextStyle(
                                            fontSize: 16
                                        ),
                                      )))
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(error, style: TextStyle(color: Colors.red),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Authenticate()));
                            },
                            child: Text('Me connecter',
                              style: TextStyle(
                                  color : Colors.white
                              ),
                            ),
                          ),

                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
