import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/data/repository/newsRepository.dart';
import 'package:riverpod_demo/domain/model/Article.dart';
import 'package:riverpod_demo/domain/model/ArticleResponse.dart';
import 'package:riverpod_demo/presentation/features/home/NewsController.dart';


final searchStringProvider = StateProvider<String>((ref) {
  return 'London';
});

final newsProvider= StateNotifierProvider.autoDispose<
    NewsController, AsyncValue<ArticleResponse>>((ref) {
  final searchString = ref.watch(searchStringProvider);
  return NewsController(NewsRepository.instance,searchQuery: searchString);
});