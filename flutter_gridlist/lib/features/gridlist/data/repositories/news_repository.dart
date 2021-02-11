import 'package:dartz/dartz.dart';
import 'package:flutter_gridlist/core/network_info.dart';
import 'package:flutter_gridlist/features/gridlist/data/datasources/articles_local_datasource.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';

import '../../domain/entities/articles_entity.dart';
import '../../domain/repositories/articles_repository.dart';
import '../datasources/articles_api_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ArticlesApiDatasource remoteApiDataSource;
  final ArticlesLocalDatasource localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl(
      {@required this.networkInfo,
      @required this.localDataSource,
      @required this.remoteApiDataSource});

  @override
  Future<Either<Failure, List<Article>>> getArticles(
    String country,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final articles = await remoteApiDataSource.getConcreteArticle(country);
        localDataSource.cacheArticleList(articles);
        return Right(articles);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheArticles = await localDataSource.getLastArticles();
        return Right(cacheArticles);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
