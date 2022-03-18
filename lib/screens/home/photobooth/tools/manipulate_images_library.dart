import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:descoloc/services/stories_firebase_storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TestImage extends StatefulWidget {
  const TestImage({Key? key}) : super(key: key);

  @override
  _TestImageState createState() => _TestImageState();
}

class _TestImageState extends State<TestImage> {

  String image = 'seoul.png';

  final FirebaseStorageService storage = FirebaseStorageService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              child: Center(
                child: ElevatedButton(
                  child: Text('upload'),
                  onPressed: () async {
                    final results = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png','jpg']
                    );
                    if(results==null){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No result')));
                      return null;
                    }
                    final path = results.files.single.path;
                    final fileName =results.files.single.name;

                    print(path);
                    storage.uploadFile(path!, fileName).then((value) => print('Upload Done'));
                  },
                ),
              )
            ),
            FutureBuilder(

              /// MODIFIER EN CONSEQUENCE LE storage.listFiles('FILEPATH')
                future: storage.listFiles(),
                builder: (BuildContext context, AsyncSnapshot<firebase_storage.ListResult> snapshot){
                  if(snapshot.connectionState == ConnectionState.done
                  && snapshot.hasData){
                    return Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.items.length,
                          itemBuilder: (BuildContext context, int index){
                          return ElevatedButton(
                              onPressed: (){
                                setState((){
                                  image=snapshot.data!.items[index].name;
                                });
                              },
                              child: Text(snapshot.data!.items[index].name));
                          }),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting
                  || !snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  return Container();
            }),
            FutureBuilder(
              future: storage.downloadURL('seculoc/',image),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                if(snapshot.connectionState == ConnectionState.done
                    && snapshot.hasData){
                  return Container(
                    height: 300,
                    width: 250,
                    child: Image.network(snapshot.data!, fit: BoxFit.cover,),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting
                    || !snapshot.hasData){
                  return CircularProgressIndicator();
                }
                return Container();
              },
            )
          ],
        )
      ),
    );
  }
}
