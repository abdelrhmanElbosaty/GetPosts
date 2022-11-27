import 'package:clean_arch/core/networkInfo.dart';
import 'package:clean_arch/features/posts/data/data_sources/local_posts_data_source.dart';
import 'package:clean_arch/features/posts/data/data_sources/remote_posts_data_source.dart';
import 'package:clean_arch/features/posts/data/repositories/post_repository_imp.dart';
import 'package:clean_arch/features/posts/domain/use_cases/add_post.dart';
import 'package:clean_arch/features/posts/domain/use_cases/delete_post.dart';
import 'package:clean_arch/features/posts/domain/use_cases/update_post.dart';
import 'package:clean_arch/features/posts/presentation/bloc/get_posts/posts_bloc.dart';
import 'package:clean_arch/features/posts/presentation/bloc/post_operation/posts_operations_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/posts/domain/repositories/post_repository/post_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features posts

  //bloc

  sl.registerFactory(() => PostsBloc(getPostsUseCase: sl()));
  sl.registerFactory(() => PostsOperationsBloc(
      addPostUseCase: sl(), updatePostUseCase: sl(), deletePostUseCase: sl()));

  //useCases

  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  //repository

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImp(
      remotePostsDataSource: sl(),
      localPostsDataSource: sl(),
      networkInfo: sl()));

  //dataSource

  sl.registerLazySingleton<RemotePostsDataSource>(
      () => RemotePostsDataSourceImp(client: sl()));
  sl.registerLazySingleton<LocalPostsDataSource>(
      () => LocalPostsDataSourceImp(sharedPreferences: sl()));

  //core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  
  //external

  final  sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
  
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
