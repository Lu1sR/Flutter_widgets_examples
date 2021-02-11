import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_gridlist/features/gridlist/data/datasources/articles_api_datasource.dart';
import 'package:flutter_gridlist/features/gridlist/data/repositories/news_repository.dart';
import 'package:flutter_gridlist/features/gridlist/domain/repositories/articles_repository.dart';
import 'package:flutter_gridlist/features/gridlist/domain/usecases/get_articles.dart';
import 'package:flutter_gridlist/features/gridlist/presentation/bloc/gridlist_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network_info.dart';
import 'features/gridlist/data/datasources/articles_local_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
    () => GridlistBloc(getArticlesUseCase: sl(), country: "us"),
  );

  // Use cases
  sl.registerLazySingleton(() => GetArticlesUseCase(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
        remoteApiDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );
  // Data sources
  sl.registerLazySingleton<ArticlesApiDatasource>(
    () => ArticlesRemoteImpl(client: sl()),
  );
  sl.registerLazySingleton<ArticlesLocalDatasource>(
    () => ArticlesLocalDatasourceImpl(sharedPreferences: sl()),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
