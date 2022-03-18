import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:descoloc/models/task.dart';
import 'package:descoloc/screens/deprecated/page_home.dart';
import 'package:descoloc/services/shared_preferences.dart';
import 'package:descoloc/services/tasks_database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'graphism_update/new_page_tasks.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nametextcontroller = new TextEditingController();
  TextEditingController _commentstextcontroller = new TextEditingController();
  TextEditingController _targettextcontroller = new TextEditingController();
  TextEditingController _pointstextcontroller = new TextEditingController();

  bool _datevisibility =
      false; // Indicates to the 1st Switch Tile whether or not to show the DatePicker
  bool _targetvisibility =
      false; // Indicates to the 2nd Switch Tile whether or not to show the Textfield for the target
  bool _pointsvisibility =
      false; // Indicates to the 3rd Switch Tile whether or not to show the Textfield for the points

  Timestamp? selectedDate = Timestamp.now();

  int points = 0;

  late final String
      idColoc; // declare the variable in which we will store the user id that we need to use GroceriesService

  void setStream() async {
    String? prefidcoloc = await ManipulateSharedPreferences()
        .getIdColoc(); //get the current coloc uid
    setState(() {
      idColoc = prefidcoloc; //setState
    });
  }

  @override
  void initState() {
    //initiate the value of the stream
    super.initState();
    setStream();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = Timestamp.fromDate(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une tâche'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Builder(
          builder: (BuildContext context) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: _nametextcontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nom de la tâche',
                      )),
                  TextFormField(
                      controller: _commentstextcontroller,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Commentaire')),
                  Padding(padding: const EdgeInsets.only(top: 25)),

                  /// Here we choose to add a deadline for the task
                  SwitchListTile(
                    title: const Text('Ajouter une deadline'),
                    value: _datevisibility,
                    onChanged: (bool value) {
                      setState(() => _datevisibility = value);
                    },
                  ),
                  Visibility(
                    visible: _datevisibility,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Select date'),
                        ),
                        Text('                            ' +
                            "${selectedDate!.toDate().toLocal()}".split(' ')[0]),
                      ],
                    ),
                  ),

                  /// Here we choose to add a target to achieve the task
                  ///

                  SwitchListTile(
                    title: const Text('Ajouter une personne en charge'),
                    value: _targetvisibility,
                    onChanged: (bool value) {
                      setState(() {
                        _targetvisibility = value;
                      });
                      if (bool == false) {
                        selectedDate = null;
                      }
                    },
                  ),
                  Visibility(
                      visible: _targetvisibility,
                      child: SizedBox(
                          width: 200,
                          child: TextFormField(
                            controller: _targettextcontroller,
                          ))),

                  /// Here we choose to add a number of points to the task
                  ///

                  SwitchListTile(
                    title: const Text('Attribuer des points'),
                    value: _pointsvisibility,
                    onChanged: (bool value) {
                      setState(() {
                        _pointsvisibility = value;
                      });
                    },
                  ),
                  Visibility(
                      visible: _pointsvisibility,
                      child: SizedBox(
                          width: 50,
                          child: TextFormField(
                            controller: _pointstextcontroller,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) => points =
                                int.parse(value), // Only numbers can be entered
                          ))),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TaskServices(idColoc: idColoc).updateTaskData(
              _nametextcontroller.text,
              _commentstextcontroller.text,
              points,
              'addedBy',
              false,
              Timestamp.now(),
              selectedDate);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TasksPageGraphism()));
        },
      ),
    );
  }
}
