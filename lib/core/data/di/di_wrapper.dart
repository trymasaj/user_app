
import 'package:get_it/get_it.dart';

/// Dependency Injection wrapper
abstract class DI {
  DI._();

  static void setSingleton<T extends Object>(T Function() creator, {String? label}) {
    GetIt.I.registerLazySingleton<T>(creator, instanceName: label);
  }

  static void setFactory<T extends Object>(T Function() creator, {String? label}) {
    GetIt.I.registerFactory<T>(creator, instanceName: label);
  }

  static void remove<T extends Object>({String? label}) {
    GetIt.I.unregister<T>(instanceName: label);
  }

  static T find<T extends Object>({String? label}) {
    return GetIt.I.get<T>(instanceName: label);
  }
}