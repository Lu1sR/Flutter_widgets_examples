part of 'gridlist_bloc.dart';

@immutable
abstract class GridlistState extends Equatable {
  @override
  List<Object> get props => [];
}

class GridlistInitial extends GridlistState {}

class GridlistError extends GridlistState {
  final String message;

  GridlistError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GridlistLoading extends GridlistState {}

class GridlistLoaded extends GridlistState {
  final List<Article> articles;
  GridlistLoaded({@required this.articles});

  @override
  List<Object> get props => [articles];
}
