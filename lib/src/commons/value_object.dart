import 'package:sa_flutter_flux_sample/src/commons/shallow_clone.dart';

/// value object has no unique identity, but has atomicIdentity
abstract class ValueObject<T> implements ShallowClone<T> {
  dynamic atomicIdentity();
}
