abstract class TodoTypeEvents {
  TodoTypeEvents._();
  static const _event = 'todo';
  static const loading = '$_event/loading';
  static const loaded = '$_event/loaded';
  static const created = '$_event/created';
  static const updated = '$_event/updated';
  static const started = '$_event/started';
  static const completed = '$_event/completed';
}

abstract class StageTypeEvents {
  StageTypeEvents._();
  static const _event = 'stage';
  static const loading = '$_event/loading';
  static const loaded = '$_event/loaded';
  static const created = '$_event/created';
  static const updated = '$_event/updated';
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

abstract class ProjectEvents {
  ProjectEvents._();
  static const _event = 'project';
  static const loaded = '$_event/loaded';
}

abstract class ManpowerEvents {
  ManpowerEvents._();
  static const _event = 'manpower';
  static const loading = '$_event/loading';
  static const loaded = '$_event/loaded';
  static const added = '$_event/added';
  static const removed = '$_event/removed';
}
