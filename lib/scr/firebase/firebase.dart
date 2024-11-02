library firebase;

import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../base/ttt_base.dart';

part 'firebase_remote_service.dart';

extension FirebaseExtension on AppStoreInterface {
  FirebaseRemoteService get firebaseRemoteService =>
      FirebaseRemoteService.instance;
}
