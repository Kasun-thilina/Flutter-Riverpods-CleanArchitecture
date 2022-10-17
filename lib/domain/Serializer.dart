import 'package:riverpod_demo/domain/model/Article.dart';

import 'model/ArticleResponse.dart';

class Serializer {
  static T fromJson<T>(dynamic json) {
    switch (T) {
      case ArticleResponse:
        return ArticleResponse.fromJson(json) as T;
      case Article:
        return Article.fromJson(json) as T;
      default:
        return json as T;
    }
  }
}
