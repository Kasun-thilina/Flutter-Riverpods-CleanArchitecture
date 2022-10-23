import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/data/repository/newsRepository.dart';
import 'package:riverpod_demo/domain/model/ArticleResponse.dart';
import 'package:riverpod_demo/presentation/features/home/newsController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';

final loadingStatusProvider = StateProvider<bool>((ref) {
  return false;
});

final searchStringProvider = StateProvider<String>((ref) {
  return 'London';
});

final searchTextProvider = StateProvider<String>((ref) {
  return '';
});

final shouldChangeText = StateProvider<bool>((ref) {
  return false;
});

final newsProvider = StateNotifierProvider.autoDispose<NewsController, AsyncValue<ArticleResponse>>((ref) {
  final searchString = ref.watch(searchStringProvider);
  return NewsController(NewsRepository.instance, searchQuery: searchString);
});

final searchToggleProvider = StateProvider<bool>((ref) {
  return false;
});

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  SearchHistoryNotifier() : super([]);

  Future<void> readSearchHistory(String text) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> searchHistory = prefs.getStringList(Constants.searchHistoryKey) ?? [];
    state = [
      for (final item in searchHistory)
        if (item.startsWith(text)) item
    ];
  }
}

final searchHistoryProvider = StateNotifierProvider<SearchHistoryNotifier, List<String>>((ref) {
  return SearchHistoryNotifier();
});
