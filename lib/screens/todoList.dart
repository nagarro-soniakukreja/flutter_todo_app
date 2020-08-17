

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as Client;


class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoListState();

}

class _TodoListState extends State<TodoList> {

  List widgets = [];
  bool showError = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  showProgressDialog() {
    return widgets.length == 0 && !showError;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo List',),
      ),
      body: getBody(),
    );
  }

  getBody() {
    if (showProgressDialog())
      return getProgressDialog();
    else
      return getListView();
  }

  getProgressDialog() {
    return Center(child: CircularProgressIndicator(),);
  }

  getListView() {
    return showError? Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 0.0),
                child: Text('Something went wrong', style: TextStyle(fontSize: 16.0),),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Give it another try', style: TextStyle(fontSize: 12.0),),
              ),
              GestureDetector(
                onTap: () {
                  showError = false;
                  getProgressDialog();
                  loadData();
                },
                child: Text('RELOAD' , style: TextStyle(color: Colors.blue, fontSize: 12.0),),
              )
            ],
          ),
        )
    )
    : ListView.builder(
        itemBuilder: (BuildContext ctx, int pos) {
          return Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                title: Text(widgets[pos]['title']),
                subtitle: Text(widgets[pos]['completed'].toString()),
              ),
            ),
          );
        }
    );
  }

  Future<void> loadData() async{
    String dataUrl = "http://jsonplaceholder.typicode.com/todos";
    Client.Response response;
    try {
      response = await Client.get(dataUrl);
    } on Exception {
      showError = true;
    }
    setState(() {
        if (response != null && response.statusCode == 200) {
          showError = false;
          widgets = json.decode(response.body);
        } else {
          showError = true;
        }
      });
    }



  }

