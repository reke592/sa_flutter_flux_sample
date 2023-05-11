import 'package:flutter/material.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.label,
    required this.items,
  });

  final String label;
  final List<Todo> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index].task),
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
