import 'package:riverpod_demo/utils/constants.dart';

import '../../utils/utils.dart';

class NewsAPI {
  final String apiKey;

  NewsAPI(this.apiKey);

  Uri searchNews(String searchQuery, int page) => _buildUri(
        endpoint: "everything",
        parametersBuilder: () => {
          "q": searchQuery,
          "from": Utils.getCurrentDate(),
          "sortBy": "popularity",
          "apiKey": apiKey,
          "pageSize": Constants.pageSize,
          "page": "$page",
        },
      );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: Constants.newsApiBaseUrl,
      path: "/v2/$endpoint",
      queryParameters: parametersBuilder(),
    );
  }
}
