import 'package:connect_hub/core/services/auth_service.dart';
import 'package:connect_hub/core/services/firestore_service.dart';
import 'package:connect_hub/features/auth/data/repos/auth_repo.dart';
import 'package:connect_hub/features/auth/data/repos/image_repo.dart';
import 'package:connect_hub/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:connect_hub/features/chat/data/repo/chat_repo.dart';
import 'package:connect_hub/features/feed/data/services/comment_service.dart';
import 'package:connect_hub/features/feed/data/services/like_service.dart';
import 'package:connect_hub/features/feed/presentation/cubits/comment_cubit.dart';
import 'package:connect_hub/features/feed/presentation/cubits/like_cubit.dart';
import 'package:connect_hub/features/feed/presentation/cubits/likes_cubit.dart';
import 'package:connect_hub/features/post/data/repos/post_repo.dart';
import 'package:connect_hub/features/post/presentation/cubits/post_cubit/post_cubit.dart';
import 'package:connect_hub/features/profile/data/repos/profile_repo.dart';
import 'package:connect_hub/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<FirestoreService>(() => FirestoreService());
  getIt.registerLazySingleton<ImageRepository>(() => ImageRepository(getIt()));
  getIt.registerLazySingleton<CommentService>(
    () => CommentService(firestoreService: getIt<FirestoreService>()),
  );
  getIt.registerLazySingleton<LikeService>(
    () => LikeService(firestoreService: getIt<FirestoreService>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      authService: getIt<AuthService>(),
      firestoreService: getIt<FirestoreService>(),
      imageRepository: getIt<ImageRepository>(),
    ),
  );

  getIt.registerLazySingleton<ChatRepo>(() => ChatRepo(getIt()));
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepository(
      firestoreService: getIt<FirestoreService>(),
      imageRepository: getIt<ImageRepository>(),
    ),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(
      authRepository: getIt<AuthRepository>(),
      firestoreService: getIt<FirestoreService>(),
    ),
  );

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(repository: getIt<ProfileRepository>()),
  );

  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
  getIt.registerFactory<PostCubit>(
    () => PostCubit(
      repository: getIt<PostRepository>(),
      authService: getIt<AuthService>(),
    ),
  );
  getIt.registerFactory<CommentCubit>(
    () => CommentCubit(
      commentService: getIt<CommentService>(),
      authService: getIt<AuthService>(),
      firestoreService: getIt<FirestoreService>(),
    ),
  );
  getIt.registerFactory<LikeCubit>(
    () => LikeCubit(
      likeService: getIt<LikeService>(),
      authService: getIt<AuthService>(),
      firestoreService: getIt<FirestoreService>(),
    ),
  );
  getIt.registerFactory<LikesViewModel>(
    () => LikesViewModel(likeService: getIt<LikeService>()),
  );
}
