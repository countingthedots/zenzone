import 'package:get_storage/get_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:zenzone/domain/diary_domain_controller.dart';

final getter = GetIt.instance;

setupLocator() {
  final box = GetStorage();
  //box.erase();
  getter.registerLazySingleton<GetStorage>(() => box);
  getter.registerLazySingleton<DiaryDomainController>(() => DiaryDomainController());
}
