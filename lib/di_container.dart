import 'package:fit_tracker/lib.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register services
  sl.registerLazySingleton(() => UserRepository());
  sl.registerLazySingleton(() => UserCubit(sl()));

  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton(() => AuthCubit(sl()));

  sl.registerLazySingleton(() => ProfileRepository());
  sl.registerLazySingleton(() => ProfileCubit(sl()));

  sl.registerLazySingleton(() => WeightRecordRepository());
  sl.registerLazySingleton(() => WeightRecordCubit(sl()));

}



