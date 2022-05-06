import 'package:flutter/material.dart';

import '../models/item.dart';

class ListItem extends StatelessWidget {
  final Item item;
  final int index;
  final Function? onClick;
  final Function? onDelete;

  const ListItem({
    required Key key,
    required this.item,
    required this.index,
    this.onClick,
    this.onDelete,
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
        onDelete is Function ? (onDelete as Function)(index) : emptyCallBack;
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
        trailing: GestureDetector(
          onDoubleTap:
              onDelete is Function ? () => onDelete!(index) : emptyCallBack,
          child: Icon(
            Icons.delete,
            color: theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
