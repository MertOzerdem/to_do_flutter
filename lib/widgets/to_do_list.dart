import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(title: Text("Item $index"));
        },
      ),
    );
  }
}
