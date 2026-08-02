import 'package:connect_hub/features/auth/data/repos/auth_repo.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setupServiceLocator()async
{
   getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<AuthRepository>()),
  );
}