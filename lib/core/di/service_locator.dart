import 'package:connect_hub/features/auth/data/repos/auth_repo.dart';
import 'package:connect_hub/features/auth/data/repos/image_repo.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';


final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<Dio>(
    () => Dio(),
  );

  getIt.registerLazySingleton<ImageRepository>(
    () => ImageRepository(getIt()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      imageRepository: getIt(),
    ),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      getIt(),
    ),
  );
}