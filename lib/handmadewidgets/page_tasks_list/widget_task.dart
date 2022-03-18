import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Item_Tasks extends StatefulWidget {

  final String name;
  final String property;

  Item_Tasks(this.name, this.property);

  @override
  State<Item_Tasks> createState() => _Item_TasksState();
}

class _Item_TasksState extends State<Item_Tasks> {


  @override
  Widget build(BuildContext context) {

    bool _value = false;

    return Material(
      color :Color(0xF615354C),
      child: InkWell(
        highlightColor: Colors.cyan,
        onTap: () {
          print("Cliqué Inkwell !");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        key: UniqueKey(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(initialValue: 'Article',),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(initialValue: 'Marque',),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                      ;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });

        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 85,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.cyan,
            ),
            key: UniqueKey(),
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Row(

                      children: <Widget>[
                        Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Icon(Icons.account_circle, size: 60),
                        ),
                        Column(
                          children: [
                            Padding(
                              key: UniqueKey(),
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 1.0, left: 1.0, right: 1.0),
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              key: UniqueKey(),
                              padding: const EdgeInsets.all(1.0),
                              child: Text(
                                widget.property,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right:10.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _value = !_value;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: _value
                                ? Icon(

                              Icons.check,
                              size: 35.0,
                              color: Colors.blue,
                              key : UniqueKey(),
                            )
                                : Icon(
                              Icons.check_box_outline_blank,
                              size: 35.0,
                              color: Colors.white,
                              key : UniqueKey(),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )

            ),
          ),
        ),

      ),
    );
  }
}






Widget affichage_tasks(bool portrait, int number) {
  var items = List<Item_Tasks>.generate(number, (i) => Item_Tasks('bla', 'property'));
  var itemsCount = items.length;
  if (portrait) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => items[index],
      itemCount: number,
    );
  } else {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: items,
    );
  }
}


Widget affichage_tasks_list(bool portrait, List<Item_Tasks> items) {
  var itemsCount = items.length;
  if (portrait) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => items[index],
      itemCount: items.length,
    );
  } else {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: items,
    );
  }
}

List<Item_Tasks> create_list(int number){
  var items = List<Item_Tasks>.generate(number, (i) => Item_Tasks('bla', 'property'));
  return items;
}

Widget affichage_tasks_list_add(bool portrait, List<Item_Tasks> items, int number) {
  final toadd = List<Item_Tasks>.generate(number, (i) => Item_Tasks('bla', 'property' ));
  items.addAll(toadd);
  var list = items;
  var itemsCount = items.length;
  if (portrait) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => list[index],
      itemCount: items.length,
    );
  } else {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3,
      children: items,
    );
  }
}