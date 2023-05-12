import 'package:sa_flutter_flux_sample/src/commons/entity.dart';

class Project extends IEntity<int, Project> {
  String project;
  final DateTime? dateKickOff;
  final DateTime? dateLive;

  Project({
    required super.id,
    required this.project,
    required this.dateKickOff,
    required this.dateLive,
  });

  factory Project.empty() => Project(
        id: 0,
        project: '',
        dateKickOff: null,
        dateLive: null,
      );

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'project': project,
      'date_kickoff': dateKickOff?.toIso8601String(),
      'date_live': dateLive?.toIso8601String(),
    };
  }

  @override
  Project copyWith({
    int? id,
    String? project,
    DateTime? dateKickOff,
    DateTime? dateLive,
  }) {
    return Project(
      id: id ?? this.id,
      project: project ?? this.project,
      dateKickOff: dateKickOff ?? this.dateKickOff,
      dateLive: dateLive ?? this.dateLive,
    );
  }
}
