import 'package:flutter/material.dart';

class PictureTile extends StatefulWidget {
  final imageURL;
  const PictureTile({Key? key, this.imageURL}) : super(key: key);

  @override
  _PictureTileState createState() => _PictureTileState();
}

class _PictureTileState extends State<PictureTile> {
  @override
  Widget build(BuildContext context) {
    final length = (1/3) * MediaQuery.of(context).size.width;
    return Container(
      height: length,
      width: length,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white//Color(0xF615354C)
        )
      ),
      child: InkWell(
        onTap: (){},
        child: ClipRect(child: Image.asset(widget.imageURL, height : length, width : length, fit: BoxFit.cover,)),
      ),

    );
  }
}
