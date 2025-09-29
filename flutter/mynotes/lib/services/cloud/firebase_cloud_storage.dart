class FirebaseCloudStorage {

  static final FirebaseCloudStorage _shared = FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}
