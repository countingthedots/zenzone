import 'package:get_storage/get_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:zenzone/domain/diary_domain_controller.dart';
import 'package:zenzone/domain/quotes_controller.dart';

final getter = GetIt.instance;

setupLocator() {
  final box = GetStorage();
  //box.erase();
  getter.registerLazySingleton<GetStorage>(() => box);
  final quotesController = QuotesController();
  
  
  getter.registerLazySingleton<DiaryDomainController>(() => DiaryDomainController());
  getter.registerLazySingleton<QuotesController>(() => quotesController);
}
