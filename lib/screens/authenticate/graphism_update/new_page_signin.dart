import 'package:descoloc/screens/authenticate/graphism_update/new_page_forgotten_password.dart';
import 'package:descoloc/services/auth.dart';
import 'package:flutter/material.dart';

class SignInPageGraphism extends StatefulWidget {
  final Function toggleView;
  const SignInPageGraphism({required this.toggleView, Key? key}) : super(key: key);

  @override
  _SignInPageGraphismState createState() => _SignInPageGraphismState();
}

class _SignInPageGraphismState extends State<SignInPageGraphism> {
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
                      child: Image.asset(
                        'assets/images/icons/png-transparent-computer-icons-home-house-desktop-service-home-blue-logo-room.png',
                        fit : BoxFit.cover,
                        height : 250,
                        width : 250,
                      ),
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
                                   hintText: 'Votre adresse mail',
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.lock, color : Colors.white),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (val) => val!.length < 8
                                  ? 'Enter an longer (8+) password'
                                  : null,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(),
                                  hintText: 'Votre mot de passe',
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
                  TextButton(
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgottenPasswordPage()));
                    },
                    child: Text('Mot de passe oublié ?',
                      style: TextStyle(
                        color: Color(0xFF646478)
                      ),
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
                                if (_formKey.currentState!.validate()) {
                                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                  if (result == null) {
                                    setState(() =>
                                    error = 'Email ou mot de passe invalide');
                                  }
                                }
                              },
                              child: Container(
                                  width : 0.6 * MediaQuery.of(context).size.width,
                                  height : 0.08 * MediaQuery.of(context).size.height,
                                  decoration : BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(90)),
                              ),
                                  child: Center(
                                      child: Text("Connexion",
                                        style: TextStyle(
                                          fontSize: 30
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
                              widget.toggleView();
                            },
                            child: Text('Créer un compte',
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
