enum UserEventStatus { NotSet, Accepted, Rejected }

UserEventStatus getStringStatForApi(String status) {
  switch (status) {
    case 'Не приду':
      return UserEventStatus.Rejected;
    case 'Приду':
      return UserEventStatus.Accepted;
    default:
      return UserEventStatus.NotSet;
  }
}

String getStringStatForUi(UserEventStatus status) {
  switch (status) {
    case UserEventStatus.NotSet:
      return 'Не решил';
    case UserEventStatus.Accepted:
      return 'Приду';
    case UserEventStatus.Rejected:
      return 'Не приду';
  }
}
