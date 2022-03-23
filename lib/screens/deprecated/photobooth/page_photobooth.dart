import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/handmadewidgets/page_photobooth/widget_photo_selector_item.dart';
import 'package:descoloc/models/memories/picture.dart';
import 'package:descoloc/models/memories/story.dart';
import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:descoloc/services/pictures_database_service.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:descoloc/services/stories_firebase_storage_service.dart';
import 'package:descoloc/services/stories_firestore_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import '../../deprecated/page_home.dart';

class PhotoBoothPage extends StatefulWidget {
  const PhotoBoothPage({Key? key}) : super(key: key);

  @override
  _PhotoBoothPageState createState() => _PhotoBoothPageState();
}

class _PhotoBoothPageState extends State<PhotoBoothPage> {
  String image = '';
  bool visibleAddStory = false;

  final TextEditingController _storyNameController = TextEditingController();

  final FirebaseStorageService storage = FirebaseStorageService();
  final StoriesCollectionServices stories = StoriesCollectionServices();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: HomeDrawer(),
        body: Builder(builder: (context) {
          final ecart = 0.05 * MediaQuery.of(context).size.height;

          return Stack(children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigoAccent, Colors.lightBlueAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      child: const Icon(Icons.menu,

                          /// Button for the Drawer menu
                          color: Colors.white),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    Center(
                      child: SizedBox(
                        height: 0.2 * MediaQuery.of(context).size.height,
                        width: 0.7 * MediaQuery.of(context).size.width,
                        child: Column(children: const [
                          Text('Coloc Stories',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white)),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Text('Retrouvez ici les moments partagés ensemble !',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white))
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 0.5 * MediaQuery.of(context).size.height,
                      child: FutureBuilder(
                        /// MODIFIER EN CONSEQUENCE LE storage.listFiles('FILEPATH')
                          future: storage.listFiles(),
                          builder: (BuildContext context,
                              AsyncSnapshot<firebase_storage.ListResult>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.items.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                         PhotoSelectorItem(image = snapshot.data!.items[index].name),
                                        ],
                                      ),
                                    );
                                  });
                            }
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                !snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return Container();
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ecart),
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              if (visibleAddStory == false) {
                                setState(() {
                                  visibleAddStory = true;
                                });
                              } else {
                                setState(() {
                                  visibleAddStory = false;
                                });
                              }
                              print(visibleAddStory.toString());
                            },
                            child: const Text('Ajouter une story')),
                      ),
                    )
                  ]),
            ),
            Visibility(
              visible: visibleAddStory,
              child: Column(verticalDirection: VerticalDirection.up, children: [
                Center(
                  child: Container(
                    width: 0.95 * MediaQuery.of(context).size.width,
                    height: 600,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        color: Color(0xFF8CD2E7)),
                    // color: Color(0xFFFFE8D6)),
                    child: TextButton(
                        onPressed: () {
                          if (visibleAddStory == false) {
                            setState(() {
                              visibleAddStory = true;
                            });
                          } else {
                            setState(() {
                              visibleAddStory = false;
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              textDirection: TextDirection.rtl,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                      Icons.arrow_drop_down_circle_outlined),
                                ),
                              ],
                            ),
                            const Center(
                              child: Text(
                                'Ajouter une story',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text('Nom de la Story'),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                controller: _storyNameController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '           '),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final results = await FilePicker.platform
                                    .pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: ['png', 'jpg']);
                                if (results == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('No result')));
                                  return null;
                                }

                                final picturePath = results.files.single.path;
                                final pictureName = results.files.first.name;
                                final id =
                                    pictureName + DateTime.now().toString();

                                print(picturePath);
                                print('PICTURE NAME  :');
                                storage
                                    .uploadFile(picturePath!, pictureName)
                                    .then((value) => print('Upload Done'));
                                PictureServices().updatePictureData(
                                    'id',
                                    pictureName,
                                    picturePath,
                                    'comment',
                                    Timestamp.now());
                                StoriesCollectionServices().updateStoriesData(
                                    id,
                                    pictureName,
                                    Timestamp.now(),
                                    Timestamp.now());
                              },
                              child: Text('Upload la première photo'),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Ajouter à la bibliothèque'),
                            )
                          ],
                        )),
                  ),
                ),
              ]),
            )
          ]);
        }),
      ),
    );
  }
}
