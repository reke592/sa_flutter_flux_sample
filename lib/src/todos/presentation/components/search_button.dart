import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/load_todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<TodoStore>();
    return Selector<TodoStore, bool>(
      selector: (_, store) => store.isLoadingTodos,
      builder: (context, isLoading, child) {
        return IconButton(
          onPressed: isLoading
              ? null
              : () {
                  store.dispatch(LoadTodo(LoadTodoParams(sprintId: 1)));
                },
          icon: const Icon(Icons.search),
        );
      },
    );
  }
}
