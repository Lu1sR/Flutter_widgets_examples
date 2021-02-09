import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';

import '../../domain/entities/articles_entity.dart';
import '../../domain/repositories/articles_repository.dart';
import '../datasources/articles_api_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final ArticlesApiDatasource remoteApiDataSource;

  NewsRepositoryImpl({@required this.remoteApiDataSource});

  @override
  Future<Either<Failure, List<Article>>> getArticles(
    String country,
  ) async {
    try {
      return Right(await remoteApiDataSource.getConcreteArticle(country));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
