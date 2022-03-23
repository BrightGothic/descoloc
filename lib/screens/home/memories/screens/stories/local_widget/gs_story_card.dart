import 'package:descoloc/screens/home/memories/models/pictures.dart';
import 'package:descoloc/screens/home/memories/models/stories.dart';
import 'package:descoloc/screens/home/memories/screens/pictures/gs_pictures.dart';
import 'package:descoloc/screens/home/memories/services/gs_pictures_services.dart';
import 'package:flutter/material.dart';

class StoryCard extends StatefulWidget {
  final Stories stories;
  final String idColoc;
  const StoryCard({required this.stories,required this.idColoc, Key? key}) : super(key: key);


  @override
  _StoryCardState createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {

  late final Future<List<Pictures>> _pictures;

  void didChangeDependencies() async {

    super.didChangeDependencies();
    final pictures = GsPicturesServices().getPictures(widget.stories.id, widget.idColoc);
    setState((){
      _pictures = pictures;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      //  clipBehavior: Clip.antiAlias,
      elevation : 6,
      color: Colors.white ,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextButton(
          onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => GsPicturesPage(stories: widget.stories, idColoc: widget.idColoc)));
          },
          child: SizedBox(
            child: Stack(
              fit: StackFit.expand,
              children: [
                FutureBuilder(
                  future: _pictures,
                    builder: (BuildContext context, AsyncSnapshot<List<Pictures>> snapshot) {
                      if(snapshot.connectionState == ConnectionState.none){
                        return Image.asset('assets/images/photos/photo_ny.png', fit: BoxFit.fitHeight,);
                      }if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueGrey,
                          ),
                        );
                      } if (snapshot.data!.isEmpty){
                        return Image.asset('assets/images/photos/photo_ny.png', fit: BoxFit.fitHeight,);
                      }else{
                        return Image.network(
                          snapshot.data!.first.filePath,
                          fit: BoxFit.fitHeight,);
                      }
                    },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      color: Colors.blue,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 6),
                          child: Text(widget.stories.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
