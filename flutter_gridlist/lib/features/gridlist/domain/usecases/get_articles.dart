import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/articles_entity.dart';
import '../repositories/articles_repository.dart';

class GetArticlesUseCase implements UseCase<List<Article>, Params> {
  final NewsRepository repository;

  GetArticlesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(Params params) async {
    return await repository.getArticles(params.country);
  }
}

class Params extends Equatable {
  final String country;

  Params({@required this.country});

  @override
  List<Object> get props => [country];
}
