import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/presentation/components/empty_widget.dart';
import 'package:riverpod_demo/presentation/features/home/homeProviders.dart';
import 'package:riverpod_demo/presentation/features/home/widgets/news_item_widget.dart';
import 'package:riverpod_demo/utils/appColors.dart';
import 'package:riverpod_demo/utils/deviceUtils.dart';
import 'package:riverpod_demo/utils/strings.dart';

import '../../components/routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchData = ref.watch(newsProvider);
    final searchText = ref.watch(searchTextProvider);
    final isSearchEnabled = ref.watch(searchToggleProvider);
    List<String> searchHistory = ref.watch(searchHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: isSearchEnabled ? 0 : 4,
        toolbarHeight: DeviceUtils.getScaledHeight(context, 0.15),
        title: Column(
          children: [
            Text(
              Strings.newsFeed,
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.012),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FocusScope(
                    child: Focus(
                      onFocusChange: (focus) {
                        ref.read(searchHistoryProvider.notifier).readSearchHistory("");
                        ref.read(searchToggleProvider.notifier).state = !isSearchEnabled;
                      },
                      child: TextFormField(
                        controller: TextEditingController()
                          ..text = searchText
                          ..selection = TextSelection.collapsed(offset: searchText.length),
                        textAlignVertical: TextAlignVertical.center,
                        onFieldSubmitted: (text) {
                          ref.read(searchStringProvider.notifier).state = text;
                        },
                        onChanged: (text) {
                          ref.read(searchTextProvider.notifier).state = text;
                          ref.read(searchHistoryProvider.notifier).readSearchHistory(text);
                        },
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.search),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 25,
                            minHeight: 25,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10, top: 10, right: 14),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Search',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 0.02),
                ),
                Visibility(
                    visible: isSearchEnabled,
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Text(
                        Strings.cancel,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.background),
                    child: searchData.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Text('Error: $err'),
                      data: (articleRes) => articleRes.articles != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: articleRes.articles?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, AppRouter.newsDetailsScreen, arguments: articleRes.articles![index]);
                                  },
                                  child: NewsItemWidget(
                                    article: articleRes.articles![index],
                                  ),
                                );
                              },
                            )
                          : emptyWidget(),
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: isSearchEnabled,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchHistory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          ref.read(searchTextProvider.notifier).state = searchHistory[index];
                          ref.read(searchToggleProvider.notifier).state = !isSearchEnabled;
                          FocusScope.of(context).requestFocus(FocusNode());
                          ref.read(searchStringProvider.notifier).state = searchHistory[index];
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: DeviceUtils.getScaledWidth(context, 0.03)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(color: AppColors.border),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: DeviceUtils.getScaledHeight(context, 0.015)),
                          child: Text(
                            searchHistory[index],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
