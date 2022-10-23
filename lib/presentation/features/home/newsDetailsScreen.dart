import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/domain/model/Article.dart';
import 'package:riverpod_demo/utils/appColors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/deviceUtils.dart';
import '../../../utils/strings.dart';

class NewsDetailsScreen extends ConsumerWidget {
  const NewsDetailsScreen({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(article.title ?? "")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(DeviceUtils.getScaledWidth(context, 0.06)),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.background,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                    )
                  ],
                ),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                    width: DeviceUtils.getScaledWidth(context, 0.3),
                    height: DeviceUtils.getScaledHeight(context, 0.3),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(article.source?.name ?? "",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12, fontWeight: FontWeight.w500)),
                  Text(
                    article.publishedAt ?? "",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                article.title ?? "",
                style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.black, fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                article.description ?? "",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 12),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: DeviceUtils.getScaledHeight(context, 0.07),
                child: TextButton(
                  onPressed: () async {
                    if (article.url != null) {
                      await launchUrl(Uri.parse(article.url!));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColors.primary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  child: Text(Strings.readFullArticle,
                      style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 18, fontWeight: FontWeight.w400)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
