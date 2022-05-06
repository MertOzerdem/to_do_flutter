import 'package:flutter/material.dart';
import 'package:to_do_flutter/widgets/list_item.dart';

import '../models/item.dart';

class ToDoList extends StatefulWidget {
  final List<Item>? items;

  const ToDoList({this.items, Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  void _onItemClick(index) {
    setState(
      () =>
          widget.items![index].isCompleted = !widget.items![index].isCompleted,
    );
  }

  void _onItemDelete(index) {
    setState(
      () => (widget.items as List<Item>).removeAt(index),
    );
    print(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items!.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Card(
              child: ListItem(
                item: widget.items![index],
                index: index,
                onClick: _onItemClick,
                onSwipe: _onItemDelete,
                key: ValueKey(
                  (widget.items as List<Item>)[index].id,
                ), // or use widget.items![index].id which cast left side automatically
              ),
            ),
            if (widget.items!.length != index + 1) const Divider(),
          ],
        );
      },
    );
  }
}
