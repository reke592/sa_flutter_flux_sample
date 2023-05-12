import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<TodoStore, bool>(
      selector: (context, store) =>
          store.isLoadingStages ||
          store.isLoadingTags ||
          store.isLoadingTodos ||
          store.isLoadingManpower,
      builder: (context, isLoading, child) {
        return Visibility(
          visible: isLoading,
          child: const FittedBox(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2,
            ),
          ),
        );
      },
    );
  }
}
