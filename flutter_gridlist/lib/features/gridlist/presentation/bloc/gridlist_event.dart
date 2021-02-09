part of 'gridlist_bloc.dart';

@immutable
abstract class GridlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetArticlesEvent extends GridlistEvent {
  final String country;

  GetArticlesEvent(this.country);

  @override
  List<Object> get props => [country];
}
