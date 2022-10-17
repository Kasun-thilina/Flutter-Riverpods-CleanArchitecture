import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/data/NetworkClient.dart';
import 'package:riverpod_demo/data/source/newsApi.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_demo/domain/model/Article.dart';
import 'package:riverpod_demo/domain/model/ArticleResponse.dart';

class NewsRepository {
  //Singleton
  NewsRepository._privateConstructor();

  static final NewsRepository _instance = NewsRepository._privateConstructor();

  static NewsRepository get instance => _instance;

  NetworkClient client = NetworkClient.instance;
  NewsAPI newsAPI = NewsAPI(dotenv.env['NewsAPI_KEY'] == null ? "" : dotenv.env['NewsAPI_KEY']!);

  Future<ArticleResponse> getForecast({required String searchQuery}) {
    return client.performWebRequest(RequestType.get, newsAPI.searchNews(searchQuery, 1));
  }
}

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepository.instance;
});
