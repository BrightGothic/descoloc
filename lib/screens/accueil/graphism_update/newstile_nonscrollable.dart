import 'package:descoloc/models/news.dart';
import 'package:descoloc/models/task.dart';
import 'package:flutter/material.dart';

class NewsTileNS extends StatefulWidget {
  final String idColoc;
  final News news;

  const NewsTileNS({required this.idColoc, required this.news, Key? key}) : super(key: key);

  @override
  _NewsTileNSState createState() => _NewsTileNSState();
}

class _NewsTileNSState extends State<NewsTileNS> {

  @override
  Widget build(BuildContext context) {

    Widget istask = Container();
    if(widget.news.type == 'task'){
      istask = TasksNews(idColoc: widget.idColoc, news: widget.news);
    }else{
      istask = GroceriesNews(idColoc: widget.idColoc, news: widget.news);
    }

    return istask;
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
    return Column(
      children: [
        Column(

          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                key: UniqueKey(),
                padding: const EdgeInsets.only(
                    right: 10.0, left: 10.0),
                child: Text(
                  widget.news.user + ' a rempli la tâche : ' + " " + widget.news.namenews,
                  maxLines : 2,
                  textDirection: TextDirection.ltr,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Padding(
              key: UniqueKey(),
              padding: const EdgeInsets.all(1.0),
              child: Text(
                'Points bonus : ' + widget.news.reward,
                style: const TextStyle(
                    color: Color(0xFF00D8FF),
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.white,
        ),
      ],
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
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            key: UniqueKey(),
            padding: const EdgeInsets.only(
                left: 10.0, right: 1.0),
            child: Text(
              widget.news.user + ' a ajouté l'"'article suivant au panier : " + " " + widget.news.namenews,
              maxLines : 2,
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15, fontWeight: FontWeight.normal),
            ),
          ),
        ),
        Divider(
          color: Colors.white,
        )
      ],
    );
  }
}
