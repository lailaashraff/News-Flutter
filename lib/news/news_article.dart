import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:url_launcher/link.dart';

import '../my_theme.dart';

class NewsArticle extends StatefulWidget {
  News news;

  static const String routeName = 'individual-article';

  NewsArticle({required this.news});

  @override
  State<NewsArticle> createState() => _NewsArticleState();
}

class _NewsArticleState extends State<NewsArticle> {
  @override
  Widget build(BuildContext context) {
    String apiDateString = widget.news.publishedAt ?? '';
    DateTime apiDate = DateTime.parse(apiDateString);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(apiDate);
    Uri newsUrl = Uri.parse(widget.news.url!);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title!),
        centerTitle: true,
      ),
      body: Padding(
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
                  imageUrl: widget.news.urlToImage ?? '',
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
              widget.news.author ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.news.title ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
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
            SizedBox(
              height: 5,
            ),
            Text(
              widget.news.content ?? "",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400, fontSize: 18, height: 1.5),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Link(
              builder: (context, followLink) {
                return TextButton(
                  onPressed: followLink,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('View Full Article',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.black,
                      )
                    ],
                  ),
                );
              },
              uri: newsUrl,
            )
          ],
        ),
      ),
    );
  }

// Future<void> _launchUrl() async {
//   if (!await launchUrl(newsUrl)) {
//     throw Exception('Could not launch $newsUrl');
//   }
//   setState(() {
//
//   });
// }
}
