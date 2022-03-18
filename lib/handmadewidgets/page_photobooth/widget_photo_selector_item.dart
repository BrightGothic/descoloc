import 'package:descoloc/models/memories/story.dart';
import 'package:descoloc/screens/home/photobooth/page_story/page_story.dart';
import 'package:descoloc/services/stories_firebase_storage_service.dart';
import 'package:flutter/material.dart';

class PhotoSelectorItem extends StatefulWidget {
  final String photoURL; //URL of the photo
  const PhotoSelectorItem(this.photoURL, {Key? key}) : super(key: key);

  @override
  _PhotoSelectorItemState createState() => _PhotoSelectorItemState();
}

class _PhotoSelectorItemState extends State<PhotoSelectorItem> {

  final FirebaseStorageService storage = FirebaseStorageService(); //folder where to find the photo
/*
  getImage() async {
    final results = FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );
    if(results == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No image found'),));
    }
  }
  */


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.downloadURL('seculoc/',widget.photoURL), // the widget wait for the photo to be download to be displayed
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        if(snapshot.connectionState == ConnectionState.done // explicit
            && snapshot.hasData){
          return Card(
            semanticContainer: true,
           //  clipBehavior: Clip.antiAlias,
            elevation : 6,
            color: Colors.white,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StoryPage()));
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(snapshot.data!,  // The card takes the downloaded picture and displays it in background
                      fit: BoxFit.cover,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      verticalDirection: VerticalDirection.up,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20),
                        ),
                        Text('Voyage à ${widget.photoURL}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting
            || !snapshot.hasData){
          return const CircularProgressIndicator();
        }
        return Container();
      },
    );
  }
}
