import 'package:flutter/material.dart';

import '../models/item.dart';

class ListItem extends StatelessWidget {
  final Item item;
  final int index;
  final Function? onClick;
  final Function? onSwipe;

  const ListItem({
    required Key key,
    required this.item,
    required this.index,
    this.onClick,
    this.onSwipe,
  }) : super(key: key);

  void emptyCallBack() {}

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Dismissible(
      key: key as Key,
      background: Container(
        color: theme.colorScheme.secondary,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        onSwipe is Function ? (onSwipe as Function)(index) : emptyCallBack();
      },
      child: ListTile(
        tileColor: theme.colorScheme.background,
        leading: GestureDetector(
          onTap: () => onClick is Function ? onClick!(index) : emptyCallBack,
          child: Icon(
            item.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
            color: item.isCompleted
                ? theme.colorScheme.secondary
                : theme.colorScheme.secondary,
          ),
        ),
        title: Text(item.title),
        trailing: Icon(
          Icons.delete,
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
