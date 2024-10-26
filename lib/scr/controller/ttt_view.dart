part of "ttt_controller.dart";

abstract class TttView<T extends TttController> extends StatelessWidget
    with LoggerMixin {
  const TttView({super.key});

  T get controller => AppStore.find();

  BuildContext get context => controller.context;

  Widget watch(Widget Function() builder) {
    return Watcher(builder);
  }
}
