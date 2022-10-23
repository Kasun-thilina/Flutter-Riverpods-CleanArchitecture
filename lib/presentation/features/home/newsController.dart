import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/data/repository/newsRepository.dart';
import 'package:riverpod_demo/domain/model/ArticleResponse.dart';
import 'package:riverpod_demo/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsController extends StateNotifier<AsyncValue<ArticleResponse>> {
  NewsController(this.newsRepository, {required this.searchQuery}) : super(const AsyncValue.loading()) {
    getWeather(searchQuery: searchQuery);
  }

  final NewsRepository newsRepository;
  final String searchQuery;

  Future<void> getWeather({required String searchQuery}) async {
    try {
      state = const AsyncValue.loading();
      //Persisting search history
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> searchHistory = prefs.getStringList(Constants.searchHistoryKey) ?? [];
      if (searchHistory.length == 6) {
        searchHistory.removeLast();
      }
      if (!searchHistory.contains(searchQuery)) {
        searchHistory.add(searchQuery);
      }
      await prefs.setStringList(Constants.searchHistoryKey, searchHistory);

      final result = await newsRepository.getForecast(searchQuery: searchQuery);
      state = AsyncValue.data(result);
    } on Exception catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
