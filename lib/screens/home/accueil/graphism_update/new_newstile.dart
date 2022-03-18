import 'package:descoloc/models/news.dart';
import 'package:descoloc/models/task.dart';
import 'package:flutter/material.dart';

class NewsTileGraphics extends StatefulWidget {
  final String idColoc;
  final News news;

  const NewsTileGraphics({required this.idColoc, required this.news, Key? key}) : super(key: key);

  @override
  _NewsTileGraphicsState createState() => _NewsTileGraphicsState();
}

class _NewsTileGraphicsState extends State<NewsTileGraphics> {

  @override
  Widget build(BuildContext context) {

    String adaptedtext = '';

    Widget istask = Container();
    if(widget.news.type == 'task'){
      istask = TasksNews(idColoc: widget.idColoc, news: widget.news);
    }else{
      istask = GroceriesNews(idColoc: widget.idColoc, news: widget.news);
    }

    return Card(
      child: InkWell(
        highlightColor: Colors.lightBlue,
        onLongPress: () async {

        },
        onTap: () {
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: istask
        ),

      ),
    );
  }
}



class TasksNews extends StatefulWidget {
  final String idColoc;
  final News news;
  const TasksNews({required this.idColoc, required this.news,Key? key}) : super(key: key);

  @override
  _TasksNewsState createState() => _TasksNewsState();
}

class _TasksNewsState extends State<TasksNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
         height: 90,
         width: 300,
      constraints: const BoxConstraints(
        minWidth: 290,
        minHeight: 70,
        maxWidth: 300,
        maxHeight: 90,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color :Color(0xF615354C),
      ),
      key: UniqueKey(),
      child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(

                children: <Widget>[

                  Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 1.0),
                          child: Text(
                            widget.news.user + ' a rempli la tâche : ' + " " + widget.news.namenews,
                            maxLines : 2,
                            textDirection: TextDirection.ltr,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            'Points bonus : ' + widget.news.reward,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )

      ),
    );
  }
}


class GroceriesNews extends StatefulWidget {
  final String idColoc;
  final News news;
  const GroceriesNews({required this.idColoc, required this.news,Key? key}) : super(key: key);

  @override
  _GroceriesNewsState createState() => _GroceriesNewsState();
}

class _GroceriesNewsState extends State<GroceriesNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
         height: 60,
         width: 300,
      constraints: const BoxConstraints(
        minWidth: 290,
        minHeight: 70,
        maxWidth: 300,
        maxHeight: 90,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color :Color(0xF615354C),
      ),
      key: UniqueKey(),
      child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(

                children: <Widget>[

                  Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: Padding(
                          key: UniqueKey(),
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 1.0),
                          child: Text(
                            widget.news.user + ' a ajouté l'"'article suivant au panier : " + " " + widget.news.namenews,
                            maxLines : 2,
                            textDirection: TextDirection.ltr,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )

      ),
    );
  }
}
