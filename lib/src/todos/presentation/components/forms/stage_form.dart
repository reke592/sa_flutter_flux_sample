import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sa_flutter_flux_sample/src/commons/message_dialog.dart';
import 'package:sa_flutter_flux_sample/src/localization/local_string.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/add_stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/actions/update_stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/stage.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/todo_store.dart';

class StageForm extends StatefulWidget {
  const StageForm({super.key, this.data});
  final Stage? data;

  @override
  State<StatefulWidget> createState() => _StageForm();
}

class _StageForm extends State<StageForm> {
  late final TextEditingController _controller;
  late bool _isInititial;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.data?.name);
    _isInititial = widget.data?.isInitial ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(localString.lAssignStage),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _controller,
            ),
            Wrap(
              spacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Checkbox(
                  value: _isInititial,
                  onChanged: (value) {
                    setState(() {
                      _isInititial = value == true;
                    });
                  },
                ),
                Text(localString.lInitialStage),
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(localString.lDiscard),
        ),
        ElevatedButton(
          onPressed: () async {
            var store = context.read<TodoStore>();
            if (_isInititial) {
              var proceed = await MessageDialog.confirm(
                context,
                localString.confirmUpdateInitialStage(store.initialStage.name),
              );
              if (!proceed) return;
            }
            if (widget.data == null) {
              store
                  .dispatch(
                    AddStage(
                      AddStageParams(
                        name: _controller.text,
                        isInitial: _isInititial,
                      ),
                    ),
                    onError: (error, stackTrace) =>
                        MessageDialog.showError(context, error, stackTrace),
                  )
                  .then((value) => Navigator.pop(context));
            } else {
              store
                  .dispatch(
                    UpdateStage(
                      UpdateStageParams(
                        id: widget.data!.id,
                        name: _controller.text,
                        isInitial: _isInititial,
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
