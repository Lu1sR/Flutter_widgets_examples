import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Article extends Equatable {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article(
      {@required this.source,
      @required this.author,
      @required this.title,
      @required this.description,
      @required this.url,
      @required this.urlToImage,
      @required this.publishedAt,
      @required this.content});

  @override
  List<Object> get props => [
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content
      ];
}

class Source extends Equatable {
  final String id;
  final String name;

  Source({@required this.id, @required this.name});

  Map<String, dynamic> toJson() {}

  @override
  List<Object> get props => [id, name];
}
