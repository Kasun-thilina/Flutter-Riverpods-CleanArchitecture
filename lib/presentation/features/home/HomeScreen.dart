import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/presentation/features/home/HomeProvider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchData= ref.watch(newsProvider);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:  [
              const Spacer(),
              searchData.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
                data: (articleRes) => Text(articleRes.articles![0].content!),
              ),
              Text("data"),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}