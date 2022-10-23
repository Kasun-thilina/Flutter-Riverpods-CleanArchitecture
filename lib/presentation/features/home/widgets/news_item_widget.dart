import 'package:flutter/material.dart';
import 'package:riverpod_demo/domain/model/Article.dart';
import 'package:riverpod_demo/utils/deviceUtils.dart';

class NewsItemWidget extends StatelessWidget {
  final Article article;

  const NewsItemWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: const Offset(1.0, 1.0),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                  width: DeviceUtils.getScaledWidth(context, 0.3),
                  height: DeviceUtils.getScaledHeight(context, 0.15),
                ),
              ),
            ),
            SizedBox(
              width: DeviceUtils.getScaledWidth(context, 0.02),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    article.title!,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.008),
                  ),
                  Text(
                    article.content!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 11, color: Colors.grey),
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, 0.01),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      article.publishedAt!,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
