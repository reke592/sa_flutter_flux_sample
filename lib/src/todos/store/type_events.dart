abstract class TodoTypeEvents {
  TodoTypeEvents._();
  static const _event = 'todo';
  static const loading = '$_event/loading';
  static const loaded = '$_event/loaded';
  static const created = '$_event/created';
  static const started = '$_event/started';
  static const completed = '$_event/completed';
}

abstract class StageTypeEvents {
  StageTypeEvents._();
  static const _event = 'stage';
  static const loading = '$_event/loading';
  static const loaded = '$_event/loaded';
  static const created = '$_event/created';
  static const deleted = '$_event/deleted';
}

abstract class TagEvents {
  TagEvents._();
  static const _event = 'tag';
  static const loading = '$_event/loading';
  static const loaded = '$_event/loaded';
  static const created = '$_event/created';
  static const deleted = '$_event/deleted';
}
