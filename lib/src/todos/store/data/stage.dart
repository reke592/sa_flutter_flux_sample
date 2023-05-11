import 'package:sa_flutter_flux_sample/src/commons/entity.dart';
import 'package:sa_flutter_flux_sample/src/todos/store/data/todo.dart';

class Stage extends IEntity<int, Stage> {
  final String name;
  final List<Todo> items;

  Stage({
    required super.id,
    required this.name,
    required this.items,
  });

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'name': name,
      'items': items.map((e) => e.asMap()).toList()
    };
  }

  @override
  Stage copyWith({
    int? id,
    String? name,
    List<Todo>? items,
  }) {
    return Stage(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }
}
