import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: ToDo(),
  ));
}

class ToDo extends StatefulWidget {
  @override
  ToDoState createState() => ToDoState();
}

class ToDoState extends State<ToDo> {
  final String url = "https://jsonplaceholder.typicode.com/todos";
  List data;

  Future<String> getTitle() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody;
    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title List"),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Text("Title: "),
                            Text(data[index]["title"],
                                style: TextStyle(
                                    fontSize: 11.0, color: Colors.black87)),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getTitle();
  }
}
