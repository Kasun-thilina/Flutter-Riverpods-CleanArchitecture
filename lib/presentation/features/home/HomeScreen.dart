import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/presentation/features/home/HomeProvider.dart';
import 'package:riverpod_demo/utils/appColors.dart';
import 'package:riverpod_demo/utils/deviceUtils.dart';
import 'package:riverpod_demo/utils/strings.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchData = ref.watch(newsProvider);
    final isSearchEnabled = ref.watch(searchToggleProvider);
    final searchHistory = ["Apple", "Covid 19", "iPhone", "Weather"];
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
                        ref.read(searchToggleProvider.notifier).state = !isSearchEnabled;
                      },
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
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
                      loading: () => const CircularProgressIndicator(),
                      error: (err, stack) => Text('Error: $err'),
                      data: (articleRes) => Text(articleRes.articles![0].content!),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isSearchEnabled,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchHistory.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        print("D");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: AppColors.border),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: DeviceUtils.getScaledHeight(context, 0.015), horizontal: DeviceUtils.getScaledWidth(context, 0.03)),
                        child: Text(
                          searchHistory[index],
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
