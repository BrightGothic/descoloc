import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/screens/home/memories/models/pictures.dart';
import 'package:descoloc/screens/home/memories/models/stories.dart';
import 'package:descoloc/screens/home/memories/services/gs_firestorage_services.dart';
import 'package:descoloc/screens/home/memories/services/gs_pictures_services.dart';
import 'package:descoloc/screens/home/tool_drawer/drawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'local_widget/gs_picture_card.dart';

class GsPicturesPage extends StatefulWidget {
  final Stories stories;
  final String idColoc;
  const GsPicturesPage({required this.stories, required this.idColoc, Key? key})
      : super(key: key);

  @override
  _GsPicturesPageState createState() => _GsPicturesPageState();
}

class _GsPicturesPageState extends State<GsPicturesPage> {
  final DateFormat formatter = DateFormat('dd-MM-yyyy');//DateFormat('MMMEd'); //   DateFormat.yMMMMd('fr'); //DateFormat('yyyy-MM-dd');

  late final Future<List<Pictures>?> _pictures;

  final SliverGridDelegate _sliverGridDelegate =
      SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150);

  void didChangeDependencies() async {
    super.didChangeDependencies();
    final pictures =
        GsPicturesServices().getPictures(widget.stories.id, widget.idColoc);
    setState(() {
      _pictures = pictures;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      body: Stack(
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
          Column(
            children: [
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
                            child: Image.asset(
                                'assets/images/photos/photo_ville.jpg',
                                height: 100,
                                width: 100,
                                fit: BoxFit.fill),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left:
                                  0.1 * MediaQuery.of(context).size.width),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.stories.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: const Text(
                                'Lorem ipsum',
                                maxLines: 4,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 0.01 *
                                        MediaQuery.of(context)
                                            .size
                                            .height)),
                            Text(
                              'Dernier ajout le : ${formatter.format(widget.stories.modified.toDate())}',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        TextButton(
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
                            final path = results.files.single.path;
                            final fileName = results.files.single.name;

                            print('Path   :  ' + path!);
                            final String idPicture =
                                widget.stories.name + fileName;
                            String pictureURL =
                                await GsFirestorageServices().uploadFile(
                                    path,
                                    widget.idColoc,
                                    widget.stories.id,
                                    idPicture);
                            GsPicturesServices().updatePictureData(
                                widget.idColoc,
                                widget.stories.id,
                                idPicture,
                                'fileName',
                                pictureURL,
                                'comment',
                                Timestamp.now());
                            print('Upload DONE');
                          },
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: FutureBuilder(
                  future: _pictures,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Pictures>?> snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: Text('Waiting'),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.none) {
                      return const Center(
                        child: Text('None'),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return GridView.builder(
                        gridDelegate: _sliverGridDelegate,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return GsPictureCard(
                                idColoc: widget.idColoc,
                                stories: widget.stories,
                                pictures: snapshot.data![index]);
                          }

                          return GsPictureCard(
                              idColoc: widget.idColoc,
                              stories: widget.stories,
                              pictures: snapshot.data![index]);
                        },
                      );
                    }
                     else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
