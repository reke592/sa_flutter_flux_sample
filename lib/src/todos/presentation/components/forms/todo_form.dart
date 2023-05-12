import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/commons/message_dialog.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/add_todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/update_todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/employee.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({
    super.key,
    this.data,
  });

  final Todo? data;

  @override
  State<StatefulWidget> createState() => _TodoForm();
}

class _TodoForm extends State<TodoForm> {
  late final TodoStore store;
  late final TextEditingController controller;
  Employee? employee;
  Stage? stage;

  @override
  void initState() {
    store = Provider.of<TodoStore>(context, listen: false);
    employee = widget.data?.assignedEmployee;
    stage = widget.data?.stage;
    controller = TextEditingController(text: widget.data?.task ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${localString.lTaskInfo} ${widget.data?.id ?? ''}'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: DropdownButton<Employee>(
                isDense: true,
                hint: Text(localString.lAssignTask),
                alignment: AlignmentDirectional.centerEnd,
                underline: Container(),
                value: employee,
                items: store.manpower
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    employee = value;
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: DropdownButton<Stage>(
                isDense: true,
                hint: Text(localString.lAssignStage),
                alignment: AlignmentDirectional.centerEnd,
                underline: Container(),
                value: stage,
                items: store.stages
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    employee = value?.isInitial == true ? null : employee;
                    stage = value;
                  });
                },
              ),
            ),
            TextField(
              textAlign: TextAlign.justify,
              minLines: 3,
              maxLines: 8,
              controller: controller,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Discard'),
        ),
        ElevatedButton(
          onPressed: () {
            var store = context.read<TodoStore>();
            if (widget.data == null) {
              store
                  .dispatch(
                    AddTodo(
                      AddTodoParams(
                        project: store.project,
                        task: controller.text,
                        assignedEmployee: employee,
                        stage: stage,
                      ),
                    ),
                    onError: (error, stackTrace) =>
                        MessageDialog.showError(context, error, stackTrace),
                  )
                  .then((value) => Navigator.pop(context));
            } else {
              store
                  .dispatch(
                    UpdateTodo(
                      UpdateTodoParams(
                        id: widget.data!.id,
                        project: store.project,
                        task: controller.text,
                        assignedEmployee: employee,
                        stage: stage,
                      ),
                    ),
                    onError: (error, stackTrace) =>
                        MessageDialog.showError(context, error, stackTrace),
                  )
                  .then((value) => Navigator.pop(context));
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
