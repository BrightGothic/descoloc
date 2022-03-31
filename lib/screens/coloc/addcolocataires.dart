import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../deprecated/page_home.dart';

class AddColocatairesPage extends StatefulWidget {

  const AddColocatairesPage({Key? key}) : super(key: key);

  @override
  _AddColocatairesPageState createState() => _AddColocatairesPageState();
}

class _AddColocatairesPageState extends State<AddColocatairesPage> {

  final TextEditingController _controller = TextEditingController();//Controller of the searchbar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width:MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigoAccent, Colors.lightBlueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top : 15),
                ),
                Center(child: Image.asset('assets/images/icons/icon_enter_house-100px.png')),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              width: 0.9 * MediaQuery.of(context).size.width,
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                maxChildSize: 1,
                minChildSize: 0.01,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xF6FFFFFF),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Center(
                            child: Padding(
                              padding:  EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Ajouter des colocataires',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Container(
                              width : 0.8  * MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xF69ED5D5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left :8.0),

                                ///TextFormField working as a search bar in this case
                                ///
                                ///
                                ///

                                child: TextFormField(
                                  controller : _controller,
                                  decoration: const InputDecoration(
                                      icon: Icon(Icons.search),
                                      border: InputBorder.none,
                                      hintText: 'Entrez l'"'identifiant de l'"'utilisateur '
                                  ),

                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Ajouer à la coloc',
          label: Row(
            children: [
              Text('Ajouter à la coloc  '),
              Icon(Icons.send)
            ],
          ),
          onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }),
    );
  }
}