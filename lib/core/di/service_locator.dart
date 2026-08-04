import 'package:connect_hub/core/services/auth_service.dart';
import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/auth/data/repos/auth_repo.dart';
import 'package:connect_hub/features/auth/data/repos/image_repo.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:connect_hub/features/chat/data/repo/chat_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerLazySingleton<ImageRepository>(() => ImageRepository(getIt()));

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      authService: getIt<AuthService>(),
      firestoreService: getIt<FirestoreService>(),
      imageRepository: getIt<ImageRepository>(),
    ),
  );

  getIt.registerLazySingleton<ChatRepo>(() => ChatRepo(getIt()));

  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
}
