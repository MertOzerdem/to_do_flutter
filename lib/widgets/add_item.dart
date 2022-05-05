import 'package:flutter/material.dart';

class AddItem extends StatelessWidget {
  final TextEditingController taskController = TextEditingController();

  AddItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        height: 100,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              autocorrect: true,
              style: TextStyle(
                color: theme.colorScheme.secondary,
              ),
              cursorColor: theme.colorScheme.secondary,
              decoration: InputDecoration(
                // border: InputBorder.none,
                labelText: 'Task: ',
                hintText: 'Enter a task...',
                hintStyle: TextStyle(
                  color: theme.colorScheme.secondary,
                ),
                filled: true,
                fillColor: theme.colorScheme.primary,
              ),
              controller: taskController,
            ),
          ],
        ));
  }
}
