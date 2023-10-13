import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/NewsResponse.dart';

import '../my_theme.dart';

class NewsArticle extends StatelessWidget {
  News news;

  NewsArticle({required this.news});

  @override
  Widget build(BuildContext context) {
    String apiDateString = news.publishedAt ?? '';
    DateTime apiDate = DateTime.parse(apiDateString);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(apiDate);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                imageUrl: news.urlToImage ?? '',
                placeholder: (context, url) => Center(
                    child: new CircularProgressIndicator(
                  color: MyTheme.primaryLight,
                )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            news.author ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            news.title ?? '',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            formattedDate,
            textAlign: TextAlign.end,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
