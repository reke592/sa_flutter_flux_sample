import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/commons/responsive_provider.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/todo_dialogs.dart';

class TodosScreenFab extends StatelessWidget {
  const TodosScreenFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ResponsiveProvider, Responsive>(
      selector: (_, pvd) => pvd.type,
      builder: (context, type, child) {
        bool isMobile = type != Responsive.mobile;
        return Wrap(
          spacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => TodoDialogs.showTodoForm(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(Icons.assignment_add),
                    if (isMobile) Text(localString.lCreateTask),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
