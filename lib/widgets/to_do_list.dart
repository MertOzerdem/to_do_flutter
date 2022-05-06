import 'package:flutter/material.dart';
import 'package:to_do_flutter/widgets/list_item.dart';

import '../models/item.dart';

class ToDoList extends StatefulWidget {
  final List<Item>? items;

  const ToDoList({this.items, Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ToDoList> createState() => _ToDoListState(
        toDoList: [
          ...items ??
              [
                Item(id: 1, title: 'Item 1', isCompleted: true),
                Item(id: 2, title: 'Item 2', isCompleted: false),
                Item(id: 3, title: 'Item 3', isCompleted: false),
              ]
        ],
      );
}

class _ToDoListState extends State<ToDoList> {
  List<Item>? toDoList;

  _ToDoListState({required this.toDoList}) : assert(toDoList != null);

  void _onItemClick(index) {
    setState(
      () => toDoList![index].isCompleted = !toDoList![index].isCompleted,
    );
  }

  void _onItemDelete(index) {
    setState(
      () => (toDoList as List<Item>).removeAt(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: toDoList!.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Card(
              child: ListItem(
                item: toDoList![index],
                index: index,
                onClick: _onItemClick,
                onSwipe: _onItemDelete,
                key: ValueKey(
                  (toDoList as List<Item>)[index].id,
                ), // or use toDoList![index].id which cast left side automatically
              ),
            ),
            if (toDoList!.length != index + 1) const Divider(),
          ],
        );
      },
    );
  }
}
