import 'package:descoloc/handmadewidgets/page_tasks_list/widget_task.dart';
import 'package:descoloc/screens/home/tasks/task_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
    @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 60, right: 20),
                  ),
                  Title(
                      color: Colors.blue,
                      child: const Text(
                        'Tâches de la coloc',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                      child: SizedBox(
                          height: 450, child: Text('Ici mettre les taches')),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              MaterialButton(
                height: 60.0,
                minWidth: 200.0,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: const Text(
                  "Ajouter une tâche",
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TaskForm()));
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
