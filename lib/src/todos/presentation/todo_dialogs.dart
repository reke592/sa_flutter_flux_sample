import 'package:flutter/material.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/forms/stage_form.dart';
import 'package:sa_flutter_flux_sample/src/todos/presentation/components/forms/todo_form.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';

abstract class TodoDialogs {
  TodoDialogs._();
  // methods
  static void showTodoForm(BuildContext context, {Todo? data}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return TodoForm(
          data: data,
        );
      },
    );
  }

  static void showStageForm(BuildContext context, {Stage? data}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StageForm(
          data: data,
        );
      },
    );
  }
}
