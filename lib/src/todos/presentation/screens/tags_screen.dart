import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/task_priority.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class TagsScreen extends StatelessWidget {
  static const routeName = '/tags';
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localString.lTagsScreenTitle),
      ),
      body: Selector<TodoStore, List<Tag>>(
        selector: (_, pvd) => pvd.tags,
        builder: (context, list, child) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                title: Text(list[index].name),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
