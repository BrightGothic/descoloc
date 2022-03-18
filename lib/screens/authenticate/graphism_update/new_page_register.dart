import 'package:descoloc/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:descoloc/screens/authenticate/authenticate.dart';

class RegisterGraphics extends StatefulWidget {

  final Function toggleView ;
  RegisterGraphics({ required this.toggleView });

  @override
  _RegisterGraphicsState createState() => _RegisterGraphicsState();
}

class _RegisterGraphicsState extends State<RegisterGraphics> {

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
                children: <Widget>[
                  const Padding(padding: EdgeInsets.all(30.0)),
                  Center(
                    child: Icon(Icons.account_circle, size: 250,)
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Icon(Icons.mail, color: Colors.white,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // border: OutlineInputBorder(),
                                hintText: 'Votre adresse mail',
                                hoverColor: Colors.white,
                                fillColor: Colors.white,
                                focusColor: Colors.white
                            ),
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
                      ],
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Icon(Icons.book, color: Colors.white,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // border: OutlineInputBorder(),
                                hintText: 'Votre prenom',
                                hoverColor: Colors.white,
                                fillColor: Colors.white,
                                focusColor: Colors.white
                            ),
                            validator: (val) => val!.isEmpty ? 'Enter an firstname' : null,
                            onChanged: (val){
                              setState(()
                              => name = val
                              );
                            },
                            /*    decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Votre adresse mail',
                            ),*/
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Icon(Icons.account_box, color: Colors.white,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // border: OutlineInputBorder(),
                                hintText: 'Votre pseudo',
                                hoverColor: Colors.white,
                                fillColor: Colors.white,
                                focusColor: Colors.white
                            ),
                            validator: (val) => val!.isEmpty ? 'Enter an pseudo' : null,
                            onChanged: (val){
                              setState(()
                              => pseudo = val
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top : 20),
                  ),
                  Center(
                    child:  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Icon(Icons.lock, color: Colors.white,),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                // border: OutlineInputBorder(),
                                  hintText: 'Mot de passe',
                                  hoverColor: Colors.white,
                                  fillColor: Colors.white,
                                  focusColor: Colors.white
                              ),
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
                        ],
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
                                  final pseudoExist = await _auth.doesPseudoExist(pseudo);
                                  if(pseudoExist){
                                    print('t es bz');
                                    setState(() =>
                                    error = 'Ce pseudo est déjà utilisé');
                                  }
                                  if(_formKey.currentState!.validate() && (pseudoExist == false)){
                                    dynamic result = await _auth.registerWithEmailAndPassword(email, name, password, pseudo);
                                    if (result == null) {
                                      print(email + name + pseudo + password);
                                      setState(() =>
                                      error = 'Rentrez un email valide');
                                    }
                                  }
                                }
                                ,
                                child: Text("S'INSCRIRE")),
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
