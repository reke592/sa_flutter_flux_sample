import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  static const routeName = '/tasks';
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Task Screen'),
    );
  }
}
