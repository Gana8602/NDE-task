import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/pages/detail_news.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NewsController _news = Get.put(NewsController());
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _news.fetchNews();
  }

  String image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTF9W9vwDNn5X7zAVeDHXgUKo0nBy0pqCaDcw&s";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("News List"),
          centerTitle: true,
        ),
        body: Obx(() {
          if (_news.news.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels ==
                      scrollNotification.metrics.maxScrollExtent &&
                  !_news.isLoading.value) {
                _news.fetchNews();
              }
              return true;
            },
            child: ListView.builder(
                itemCount: _news.news.length,
                itemBuilder: (context, index) {
                  final n = _news.news;
                  DateTime parsedDateTime = DateTime.parse(n[index].date);
                  String formattedDateTime =
                      DateFormat('yyyy-MM-dd HH:mm').format(parsedDateTime);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => DetailsPage(
                              keywords: n[index].content,
                              img: n[index].image!,
                              description: n[index].description,
                              title: n[index].title,
                              date: formattedDateTime,
                              source: n[index].source,
                            ));
                      },
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 15,
                                offset: const Offset(0, 3),
                                color: Colors.grey.withOpacity(0.3),
                              )
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 138,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                image: DecorationImage(
                                    image: NetworkImage(n[index].image!),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SizedBox(
                                height: 47,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            n[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Text(
                                          formattedDateTime,
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    Text(
                                      n[index].description,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        }));
  }
}
