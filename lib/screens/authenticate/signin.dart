import 'package:descoloc/services/auth.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        appBar: AppBar(
          title: Text('Connexion'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 1000,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(20.0)),
                  Center(
                    key: UniqueKey(),
                    child: const Text(
                      'Connexion',
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(40.0)),
                  Center(
                    key: UniqueKey(),
                    child: const Text(
                      'Adresse mail',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                    top: 20.0,
                  )),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        /*    decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Votre adresse mail',
                        ),*/
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(22.0)),
                  Center(
                    child: const Text(
                      'Mot de Passe',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                    top: 20.0,
                  )),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (val) => val!.length < 8
                            ? 'Enter an longer (8+) password'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        obscureText: true,
                        /*   decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Votre mot de passe',
                        ),*/
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                    top: 20.0,
                  )),
                  Center(
                      //     child: TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Connexion()));}, child: Text("Créer un compte")),
                      ),
                  const Padding(
                      padding: EdgeInsets.only(
                    top: 20.0,
                  )),
                  Builder(builder: (context) {
                    return Center(
                        child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            widget.toggleView();
                          },
                          child: Text('Créer un compte'),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                          top: 20.0,
                        )),
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
                            child: Text("SE CONNECTER")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(error, style: TextStyle(color: Colors.red),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              print(email);
                              print(password);
                              dynamic result = await _auth.signInAnon();
                              if (result == null) {
                                print('error sign in ');
                              } else {
                                print(email);
                                print(password);
                                print('Signed in');
                                print(result.uid);
                              }
                            },
                            child: const Text('Mot de passe oublié')
                        ),
                      ],
                    ));
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
