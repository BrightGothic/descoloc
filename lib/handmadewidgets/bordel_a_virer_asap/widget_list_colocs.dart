import 'package:descoloc/models/coloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ColocList extends StatefulWidget {
  const ColocList({Key? key}) : super(key: key);

  @override
  _ColocListState createState() => _ColocListState();
}

class _ColocListState extends State<ColocList> {
  @override
  Widget build(BuildContext context) {

    final colocs = Provider.of<List<Coloc>?>(context);

    return ListView.builder(
      itemCount: colocs!.length,
      itemBuilder: (context, index){
       return Container();
      },
    );
  }
}
