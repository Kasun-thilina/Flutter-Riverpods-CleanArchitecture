import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/data/repository/newsRepository.dart';
import 'package:riverpod_demo/domain/model/Article.dart';
import 'package:riverpod_demo/domain/model/ArticleResponse.dart';

class NewsController extends StateNotifier<AsyncValue<ArticleResponse>> {
  NewsController(this.newsRepository, {required this.searchQuery}) : super(const AsyncValue.loading()) {
    getWeather(searchQuery: searchQuery);
  }

  final NewsRepository newsRepository;
  final String searchQuery;

  Future<void> getWeather({required String searchQuery}) async {
    try {
      state = const AsyncValue.loading();
      final result = await newsRepository.getForecast(searchQuery: searchQuery);
      state = AsyncValue.data(result);
    } on Exception catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
