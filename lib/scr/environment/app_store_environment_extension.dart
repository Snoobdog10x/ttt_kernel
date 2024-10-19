import '../base/app_store_interface.dart';
import 'environment_service.dart';

extension AppStoreAppInfoExtension on AppStoreInterface {
  EnvironmentService get environmentService => EnvironmentService.instance;
}
