import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/employee.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class ManpowerScreen extends StatelessWidget {
  static const routeName = '/manpower';
  const ManpowerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localString.lManpowerScreenTitle),
      ),
      body: Selector<TodoStore, List<Employee>>(
        selector: (_, pvd) => pvd.manpower,
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
