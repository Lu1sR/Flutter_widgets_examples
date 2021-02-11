import 'dart:convert';
import 'package:flutter_gridlist/core/errors/exceptions.dart';
import 'package:flutter_gridlist/features/gridlist/data/models/news_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter_gridlist/features/gridlist/data/models/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ArticlesLocalDatasource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<ArticleModel>> getLastArticles();

  Future<void> cacheArticleList(List<ArticleModel> articletoCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class ArticlesLocalDatasourceImpl implements ArticlesLocalDatasource {
  final SharedPreferences sharedPreferences;

  ArticlesLocalDatasourceImpl({@required this.sharedPreferences});

  @override
  Future<List<ArticleModel>> getLastArticles() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      var news = json.decode(jsonString);
      var listArticles = List<ArticleModel>.generate(
          news.length, (index) => ArticleModel.fromJson(news[index]));
      return Future.value(listArticles);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheArticleList(List<ArticleModel> articlestoCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(
          articlestoCache.sublist(1, 6).map((e) => e.toJson()).toList()),
    );
  }
}
