import 'package:sa_flutter_flux_sample/src/commons/entity.dart';

class Tag extends IEntity<int, Tag> {
  final int level;
  final String name;

  Tag({
    required super.id,
    required this.level,
    required this.name,
  });

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'level': level,
      'name': name,
    };
  }

  @override
  Tag copyWith({
    int? id,
    int? level,
    String? name,
  }) {
    return Tag(
      id: id ?? this.id,
      level: level ?? this.level,
      name: name ?? this.name,
    );
  }
}
