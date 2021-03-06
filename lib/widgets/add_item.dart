import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../models/item.dart';

class AddItem extends StatelessWidget {
  final void Function(ItemList) onSubmit;
  final ItemList itemList;
  final TextEditingController taskController = TextEditingController();

  AddItem({
    required this.onSubmit,
    required this.itemList,
    Key? key,
  }) : super(key: key);

  // List<Item> getNewList() {
  //   Item biggestIdItem = itemList.first;

  //   for (Item item in itemList) {
  //     if (item.id > biggestIdItem.id) biggestIdItem = item;
  //   }

  //   Navigator.pop(context);

  //   return [
  //     ...itemList,
  //     Item(
  //       id: biggestIdItem.id + 1,
  //       title: taskController.text,
  //       isCompleted: false,
  //     ),
  //   ];
  // }

  void setNewList() {
    Item biggestIdItem = itemList.items.firstOrNull ??
        Item(id: 0, title: taskController.text, isCompleted: false);

    for (Item item in itemList.items) {
      if (item.id > biggestIdItem.id) biggestIdItem = item;
    }

    onSubmit(
      ItemList(
        [
          ...itemList.items,
          Item(
            id: biggestIdItem.id + 1,
            title: taskController.text,
            isCompleted: false,
          ),
        ],
      ),
    );

    // onSubmit([
    //   ...itemList.items,
    //   Item(
    //     id: biggestIdItem.id + 1,
    //     title: taskController.text,
    //     isCompleted: false,
    //   ),
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autocorrect: true,
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                ),
                cursorColor: theme.colorScheme.secondary,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  labelText: 'Task: ',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Enter a task...',
                  hintStyle: TextStyle(
                    color: theme.colorScheme.secondary,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.primary,
                ),
                controller: taskController,
              ),
            ),
            Padding(
              // padding: const EdgeInsets.only(top: 0, bottom: 16.0),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16),
              child: ElevatedButton(
                onPressed: () {
                  setNewList();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ));
  }
}
