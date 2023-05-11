import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/commons/responsive_provider.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class TagsScreenFab extends StatelessWidget {
  const TagsScreenFab({super.key});

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
              onPressed: () {
                context.read<TodoStore>();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    if (isMobile) const Text('Create Tag'),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TodoStore>();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(Icons.delete),
                    if (isMobile) const Text('Delete Tag'),
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
