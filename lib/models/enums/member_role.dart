enum UserEventStatus { Member, Administrator, Creator }

String getStringStatForApi(bool role) {
  switch (role) {
    case true:
      return 'Administrator';
    default:
      return 'Member';
  }
}
