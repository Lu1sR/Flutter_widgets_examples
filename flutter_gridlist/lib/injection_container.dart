import 'package:flutter_gridlist/features/gridlist/data/datasources/articles_api_datasource.dart';
import 'package:flutter_gridlist/features/gridlist/data/repositories/news_repository.dart';
import 'package:flutter_gridlist/features/gridlist/domain/repositories/articles_repository.dart';
import 'package:flutter_gridlist/features/gridlist/domain/usecases/get_articles.dart';
import 'package:flutter_gridlist/features/gridlist/presentation/bloc/gridlist_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

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
      remoteApiDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<ArticlesApiDatasource>(
    () => ArticlesRemoteImpl(client: sl()),
  );

  sl.registerLazySingleton(() => http.Client());
}
