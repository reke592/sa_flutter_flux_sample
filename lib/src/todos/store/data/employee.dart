import 'package:sa_flutter_flux_sample/src/commons/entity.dart';

class Employee extends IEntity<int, Employee> {
  Employee({
    required super.id,
    required this.name,
  });

  final String name;

  @override
  Map<String, dynamic> asMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  Employee copyWith({
    int? id,
    String? name,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
