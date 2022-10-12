import 'package:riverpod_demo/data/source/newsApi.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  NewsRepository({required this.newsAPI, required this.client});

  final NewsAPI newsAPI;
  final http.Client client;
}
