import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class StageList extends StatelessWidget {
  const StageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TodoStore, List<Stage>>(
      selector: (_, pvd) => pvd.stages,
      child: const Text('Stages'),
      builder: (context, list, title) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title!,
                Text(
                  '(${list.length})',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    title: Text(list[index].name),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
