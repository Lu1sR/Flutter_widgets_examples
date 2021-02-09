import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/articles_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getArticles(String country);
}
