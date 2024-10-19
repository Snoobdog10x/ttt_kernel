import 'ttt_controller.dart';

abstract class Binding {
  List<TttController Function()> getControllers();
}
