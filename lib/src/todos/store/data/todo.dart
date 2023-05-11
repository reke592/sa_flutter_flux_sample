import 'package:sa_flutter_flux_sample/src/commons/entity.dart';

class Todo extends IEntity {
  final int sprintId;
  final String task;
  final String remarks;
  final DateTime? dateCreated;
  final DateTime? dateStarted;
  final DateTime? dateCompleted;

  Todo({
    required super.id,
    required this.sprintId,
    required this.task,
    this.remarks = '',
    this.dateCreated,
    this.dateStarted,
    this.dateCompleted,
  });

  @override
  copyWith({
    int? id,
    int? sprintId,
    String? task,
    String? remarks,
    DateTime? dateCreated,
    DateTime? dateStarted,
    DateTime? dateCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      sprintId: sprintId ?? this.sprintId,
      task: task ?? this.task,
      remarks: remarks ?? this.remarks,
      dateCreated: dateCreated ?? this.dateCreated,
      dateStarted: dateStarted ?? this.dateStarted,
      dateCompleted: dateCompleted ?? this.dateCompleted,
    );
  }

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'task': task,
      'remarks': remarks,
      'date_created': dateCreated?.toIso8601String(),
      'date_started': dateStarted?.toIso8601String(),
      'date_completed': dateCompleted?.toIso8601String(),
    };
  }
}
