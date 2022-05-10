import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:to_do_flutter/widgets/list_item.dart';

import '../models/item.dart';

class ToDoList extends StatefulWidget {
  final ItemList? items;

  const ToDoList({this.items, Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final LocalStorage storage = LocalStorage('todo_app');
  void _onItemClick(index) {
    setState(() {
      widget.items!.items[index].isCompleted =
          !widget.items!.items[index].isCompleted;

      storage.setItem('todos', widget.items!.toJSONEncodable());
    });
  }

  void _onItemDelete(index) {
    setState(() {
      widget.items!.items.removeAt(index);
      storage.setItem('todos', widget.items!.toJSONEncodable());

      // () => (widget.items as List<Item>).removeAt(index),
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items?.items.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Card(
              child: ListItem(
                item: widget.items!.items[index],
                index: index,
                onClick: _onItemClick,
                onDelete: _onItemDelete,
                key: ValueKey(
                  widget.items!.items[index].id,
                  // (widget.items as List<Item>)[index].id,
                ), // or use widget.items![index].id which cast left side automatically
              ),
            ),
            if (widget.items?.items.length != index + 1) const Divider(),
          ],
        );
      },
    );
  }
}
