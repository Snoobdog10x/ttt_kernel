part of 'firebase.dart';

class FirebaseRemoteService extends TttService {
  static FirebaseRemoteService instance = FirebaseRemoteService._();

  FirebaseRemoteService._();

  @override
  Future<void> onInit() async {
    await super.onInit();

    await FirebaseRemoteConfig.instance.ensureInitialized();
    await FirebaseRemoteConfig.instance.fetchAndActivate();

    FirebaseRemoteConfig.instance.onConfigUpdated.listen(
      (_) {
        FirebaseRemoteConfig.instance.fetchAndActivate();
      },
      onError: (_) {},
    );
  }
}
