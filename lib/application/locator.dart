import 'package:get_storage/get_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

setupLocator() {
  final box = GetStorage();
  //box.erase();
  locator.registerLazySingleton<GetStorage>(() => box);
}
