import 'package:descoloc/handmadewidgets/page_story/widget_picture_tile.dart';
import 'package:descoloc/models/memories/story.dart';
import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {

  const StoryPage({Key? key}) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.indigoAccent, Colors.lightBlueAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),

              ),

              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Button for the Drawer menu


                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xF615354C),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 10,
                              ),
                              CircleAvatar(
                                minRadius: 20,
                                maxRadius: 40,
                                child: ClipOval(
                                  child: Image.asset('assets/images/photos/photo_ville.jpg',
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left : 0.1 *MediaQuery.of(context).size.width),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.toString(),
                                    style: TextStyle(
                                        color : Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top : 8),
                                  ),
                                  Text('Créée le : 0000000',
                                    style: TextStyle(
                                      color : Colors.white
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top : 0.01 *MediaQuery.of(context).size.height)),
                                  Text('Dernier ajout le : 0000000',
                                    style: TextStyle(
                                        color : Colors.white
                                    ),
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: (){},
                                child: Icon(Icons.add_circle_outline, color: Colors.white,),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 10),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Wrap(
                        children: [
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_city.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ny.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_city.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ny.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_city.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ny.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_city.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ny.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_city.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ny.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/Brick_300x100.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_city.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ny.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ronde.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/Brick_300x100.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_city.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ny.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ronde.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),
                          PictureTile(imageURL :'assets/images/photos/Brick_300x100.jpg'),
                          PictureTile(imageURL :'assets/images/photos/photo_city.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ny.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_ronde.png'),
                          PictureTile(imageURL :'assets/images/photos/photo_sunset.jpg'),

                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: TextButton(
                  child: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
