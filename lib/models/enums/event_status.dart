enum EventStatus {
  Featured,
  Passed,
  Canceled
}

String getStringEventStatForUi(EventStatus status) {
  switch (status) {
    case EventStatus.Featured:
      return 'Состоится';
    case EventStatus.Passed:
      return 'Состоялось';
    case EventStatus.Canceled:
      return 'Отменено';
  }
}

