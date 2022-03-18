import 'package:descoloc/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:descoloc/screens/authenticate/authenticate.dart';

class Register extends StatefulWidget {

  final Function toggleView ;
  Register({ required this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey <FormState>();

  String email = '';
  String name = '';
  String password = '';
  String pseudo = '';
  String error ='';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Créer votre compte'),
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
                      'Inscrivez-vous',
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(40.0)),
                  Center(
                    key: UniqueKey(),
                    child: const Text(
                      'Entrez votre adresse mail',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
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
                       validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val){
                          setState(()
                          => email = val
                          );
                        },
                        /*    decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Votre adresse mail',
                        ),*/
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(22.0)),
                  const Center(
                    child: Text(
                      'Entrez votre mot de passe',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      )),
                  Center(
                    child:  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (val) => val!.length < 8 ? 'Enter an longer (8+) password' : null,
                        onChanged: (val){
                          setState(()
                          => password = val
                          );
                        },

                        obscureText : true,
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
                  Text("Veuillez choisir un pseudonyme"),
                  const Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                      )),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        validator: (val) => val!.isEmpty ? 'Enter a password' : null,
                        onChanged: (val){
                          setState(()
                          => pseudo = val
                          );
                        },

                      ),
                    ),
                  ),

                  Builder(builder: (context) {
                    return Center(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                widget.toggleView();
                              },
                              child: Text('J"'"ai un déjà un compte"),

                            ),
                            ElevatedButton(
                                onPressed: ()  async {
                                  final bool pseudoExist = await _auth.doesPseudoExist(pseudo);
                                  if(pseudoExist){
                                    setState(() =>
                                    error = 'Ce pseudo est déjà pris');
                                    return null;
                                  }
                                  if(_formKey.currentState!.validate() && (pseudoExist == false)){
                                    dynamic result = await _auth.registerWithEmailAndPassword(email, name, password, pseudo);
                                    if (result == null) {
                                      setState(() =>
                                      error = 'Rentrez un email valide');
                                    }
                                  }
                                  }
                                ,
                                child: Text('S"'"INSCRIRE")),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(error, style: TextStyle(color: Colors.red),
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
