import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gridlist/core/errors/failures.dart';
import 'package:flutter_gridlist/features/gridlist/domain/entities/articles_entity.dart';
import 'package:flutter_gridlist/features/gridlist/domain/usecases/get_articles.dart';
import 'package:meta/meta.dart';
part 'gridlist_event.dart';
part 'gridlist_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class GridlistBloc extends Bloc<GridlistEvent, GridlistState> {
  final GetArticlesUseCase getArticlesUseCase;
  final String country;
  GridlistBloc({
    @required this.getArticlesUseCase,
    @required this.country,
  }) : super(GridlistInitial());

  @override
  Stream<GridlistState> mapEventToState(
    GridlistEvent event,
  ) async* {
    if (event is GetArticlesEvent) {
      yield GridlistLoading();
      final failureOrSuccess =
          await getArticlesUseCase(Params(country: this.country));
      yield failureOrSuccess.fold(
          (failure) => GridlistError(message: _mapFailureToMessage(failure)),
          (articles) => GridlistLoaded(articles: articles));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
