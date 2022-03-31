import 'package:descoloc/screens/accueil/graphism_update/new_page_accueil.dart';
import 'package:descoloc/screens/tool_drawer/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'homecategorywidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const HomeDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex : 10,
            child: Stack(
              children: [
                Container(
                  color: Colors.green,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top : _height * 0.03, left : 76, bottom: 20),
                      child: SizedBox(
                        height: _height * 0.08,
                        width: _width * 0.6,
                        child: Row(
                          children: const [
                            Text(
                              "Hello Benjamin ! ",
                              style: TextStyle(
                                  fontSize: 20,
                                  color : Colors.white),)
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AccueilPageGraphism()));
                            },
                            child: SizedBox(
                              height: _height * 0.13,
                              width: _width * 0.9,
                              child: Container(
                                color: Color(0x4F92EA92),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left : 16.0),
                                    child: Column(
                                        mainAxisAlignment : MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'The insides',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white
                                            ),
                                          ),
                                          Text(
                                            'Click fast to know about it',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                color: Colors.white
                                            ),
                                          )
                                        ],
                                      ),
                                  ),
                                    Padding(
                                      padding: const EdgeInsets.only(right : 16.0),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top : 40.0, left : 16),
                  child: Icon(Icons.arrow_back, color: Colors.white, size : 30),
                ),

              ],
            ),
          ),
            Flexible(
              flex : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Your space", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 20,
              child: Center(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 0.05 * _width,
                    children: [
                      HomeCategoryWidget(type : 'task'),
                      HomeCategoryWidget(type : 'memories'),
                      HomeCategoryWidget(type : 'groceries'),
                      HomeCategoryWidget(type : 'coloc'),
                      HomeCategoryWidget(type : 'settings'),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
