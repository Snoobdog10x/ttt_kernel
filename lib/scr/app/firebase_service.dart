part of 'ttt_app.dart';

class FirebaseService extends TttService {
  static FirebaseService instance = FirebaseService._();

  FirebaseService._();

  @override
  Future<void> onInit() async {
    await super.onInit();
    await Firebase.initializeApp(options: AppStore.firebaseOptions);
  }

  @override
  InitPriority get initPriority => InitPriority.ON_START_UP;

  @override
  int get order => -2;
}
