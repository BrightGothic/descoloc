import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/colocataire.dart';
import 'package:descoloc/models/task.dart';

import 'package:descoloc/services/tasks_database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ItemTasksv3 extends StatefulWidget {
  final String? idColoc;
  final Task task;
  ItemTasksv3(this.idColoc, this.task);

  @override
  State<ItemTasksv3> createState() => _ItemTasksv3State();
}

class _ItemTasksv3State extends State<ItemTasksv3> {

  late String nameUser = 'Ca foire';


  final DateFormat formatter = DateFormat(
      'MMMEd'); //   DateFormat.yMMMMd('fr'); //DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot<Map<String, dynamic>>>? streamDone =
        FirebaseFirestore.instance
        .collection('colocs/' + widget.idColoc! + '/colocataires')
        .where('uid', isEqualTo: widget.task.achievedBy)
        .snapshots();

    print(widget.task.achievedBy);
    Color colordonemainbox = Color(0xFF9B9ECE);
    Color colordonetopbox = Color(0xFF9B9ECE);

    if(!widget.task.done){
        colordonemainbox = Color(0xFF3E6FEA);
        colordonetopbox = Color(0xFF44AEE7);

      //colordonetopbox = Colors.indigoAccent;
      //  colordonemainbox = Color(0xFF473BF0);
    }
    return Container(
      height: 145,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color : colordonemainbox,
        border: Border.all(
        ),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: StreamBuilder(
        stream: streamDone,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.connectionState == ConnectionState.active) {
            print(snapshot.data!.docs.isEmpty.toString());
            Colocataire userwhoachivedthetask = Colocataire.fromJSON(
                snapshot.data!.docs.first.data() as Map<
                    String,
                    dynamic>);
            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      heightFactor: 0.6,
                      child: Container(
                          child: Center(
                              child: Text(
                                  formatter.format(widget.task.deadline!.toDate()).toString()
                              )
                          ),
                        decoration: BoxDecoration(
                          color: colordonetopbox,
                          borderRadius: const BorderRadius.only(bottomLeft : Radius.circular(20),bottomRight : Radius.circular(20)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: TextButton(
                      onLongPress: () async {

                      },
                      onPressed: () {
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Container(
                              decoration: BoxDecoration(
                                color : colordonemainbox,
                              ),
                              child: Column(
                                children: [
                                  ClipRect(
                                    child: Text(
                                     widget.task.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ClipRect(
                                    child: Text(
                                      widget.task.property,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16, fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            decoration:const  BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color : Color(0xFF67AEDE),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${widget.task.reward.toString()} pt",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24
                                ),
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !widget.task.done,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.15 * MediaQuery.of(context).size.width),
                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           ElevatedButton(
                                    onPressed: () async {

                                  TaskServices(idColoc: widget.idColoc).isTaskDone(widget.task,userwhoachivedthetask,  true);

                                    },child: Row(
                                  children: const [
                                    Text('Valider',
                                        style : TextStyle(
                                            color: Colors.white
                                        )),
                                    Icon(Icons.done, color: Colors.white),
                                  ],
                                ),
                                  style: ElevatedButton.styleFrom(
                                    //   shape: CircleBorder(),
                                    padding: EdgeInsets.all(10),
                                    primary: Color(0xff3db7d4), // <-- Button color
                                    onPrimary: Colors.red, // <-- Splash color
                                  ),
                                ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                          ),


                          ElevatedButton(
                            onPressed: () async {
                              TaskServices(idColoc: widget.idColoc).deleteTask(widget.task,userwhoachivedthetask);

                            },
                            child: Row(
                              children:const [
                                Text('Supprimer',
                                  style : TextStyle(
                                    color: Colors.white
                                  )
                                ),
                                Icon(Icons.clear, color: Colors.white),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                         //     shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                              primary: Colors.red, // <-- Button color
                              onPrimary: Colors.red, // <-- Splash color
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.task.done,
                      child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                        width: 0.6 * MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        child: Center(
                                          child: Text('Fait par ' + userwhoachivedthetask.name + ' !',
                                          style: TextStyle(
                                            color : Colors.white
                                          ),),
                                        )),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      TaskServices(idColoc: widget.idColoc).isTaskDone(widget.task,userwhoachivedthetask,  false);
                                    },
                                    child: Icon(Icons.clear, color: Colors.white),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(10),
                                      primary: Color(0xff707b92), // <-- Button color
                                      onPrimary: Color(0xff707b92), // <-- Splash color
                                    ),
                                  )
                                ],
                              ),

                        )
        ],
      );
  }else{
  return const Text('Loading');
  }
},),
    );
  }
}




