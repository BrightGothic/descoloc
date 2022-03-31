import 'package:descoloc/screens/coloc/graphics_update/new_page_colocs.dart';
import 'package:descoloc/screens/groceries/groceries_graphic_update/new_page_groceries.dart';
import 'package:descoloc/screens/memories/screens/stories/gs_stories.dart';
import 'package:descoloc/screens/tasks/graphism_update/new_page_tasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeCategoryWidget extends StatefulWidget {
  final String type;
  const HomeCategoryWidget({required this.type,Key? key}) : super(key: key);

  @override
  State<HomeCategoryWidget> createState() => _HomeCategoryWidgetState();
}

class _HomeCategoryWidgetState extends State<HomeCategoryWidget> {
  @override
  Widget build(BuildContext context) {

    double _fontSize = 20;

    late IconData _icon;
    late String _name;
    late Color _iconColor;
    late Color _roundColor;
    late Widget _route;

    switch (widget.type){
      case 'task' : {
        _icon = Icons.task;
        _name = 'Tasks';
        _iconColor = Color(0xF607CB07);
        _roundColor = Color(0x4F07CB07);
        _route = TasksPageGraphism();
      }
      break;
      case 'memories' : {
        _icon = Icons.photo;
        _name = 'Memories';
        _iconColor = Color(0xF607CBC4);
        _roundColor = Color(0x4F07CBC4);
        _route = GsStoriesPage(idColoc: "vIq0A7F9ubVlmlAQ2e9O");
      }
      break;
      case 'groceries' : {
        _icon = Icons.local_grocery_store;
        _name = 'Groceries';
        _iconColor = Color(0xF6EEDB43);
        _roundColor = Color(0x4FEEDB43);
        _route = GroceriesPageGraphism();
      }
      break;
      case 'coloc' : {
        _icon = Icons.group;
        _name = 'My Coloc';
        _iconColor = Color(0xF6CB5507);
        _roundColor = Color(0x4FCB5507);
        _route = ColocsPageGraphics(idColoc: "vIq0A7F9ubVlmlAQ2e9O");
      }
      break;
      case 'settings' : {
        _icon = Icons.settings;
        _name = 'Settings';
        _iconColor = Color(0xF64E4E4E);
        _roundColor = Color(0x4F4E4E4E);

      }
      break;
      default:{

      }
      break;
    }
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 15,
      child: SizedBox(
        height: 0.3 * _height,
        width: 0.2 * _height,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => _route));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Icon(
                      Icons.circle,
                      size: _height * 0.15,
                      color : _roundColor
                  ),
                  Icon(
                    _icon,
                    size: _height * 0.1,
                    color : _iconColor
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(3),
              ),
              Column(
                children: [
                  Text(_name, style : TextStyle(fontSize: _fontSize, color: Colors.black)),
                  Text("24 to do ", style : TextStyle(fontSize: _fontSize, color: Colors.black))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
