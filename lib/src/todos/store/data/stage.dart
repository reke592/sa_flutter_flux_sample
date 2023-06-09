import 'package:sa_flutter_flux_sample/src/commons/entity.dart';

class Stage extends IEntity<int, Stage> {
  final String name;
  final bool isInitial;

  Stage({
    required super.id,
    required this.name,
    required this.isInitial,
  });

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'name': name,
      'is_initial': isInitial,
    };
  }

  @override
  Stage copyWith({
    int? id,
    String? name,
    bool? isInitial,
  }) {
    return Stage(
      id: id ?? this.id,
      name: name ?? this.name,
      isInitial: isInitial ?? this.isInitial,
    );
  }
}
