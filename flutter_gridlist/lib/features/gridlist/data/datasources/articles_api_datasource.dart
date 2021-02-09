import 'dart:convert';

import 'package:flutter_gridlist/features/gridlist/data/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/article_model.dart';
import 'package:flutter_gridlist/core/constants.dart';

abstract class ArticlesApiDatasource {
  /// Calls the http://newsapi.org/v2/top-headlines?country={country-code} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ArticleModel>> getConcreteArticle(String country);
}

class ArticlesRemoteImpl implements ArticlesApiDatasource {
  final http.Client client;

  ArticlesRemoteImpl({@required this.client});

  @override
  Future<List<ArticleModel>> getConcreteArticle(String country) {
    return _getTriviaFromUrl('http://newsapi.org/v2/top-headlines?'
        'country=$country&'
        'apiKey=$API_KEY');
  }

  Future<List<ArticleModel>> _getTriviaFromUrl(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return NewsModel.fromJson(json.decode(response.body)).articles;
    } else {
      throw ServerException();
    }
  }
}
