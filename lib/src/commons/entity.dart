import 'package:sa_flutter_flux_sample/src/commons/json_serializable.dart';
import 'package:sa_flutter_flux_sample/src/commons/shallow_clone.dart';

/// an entity with unique identity
///
/// immplements: [ShallowClone]
abstract class IEntity<T, E> implements IJsonSerializable, ShallowClone<E> {
  IEntity({required this.id});
  final T id;
}
