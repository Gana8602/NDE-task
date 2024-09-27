import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/services/news_service.dart';
import '../services/db_helper.dart';

class NewsController extends GetxController {
  var news = <NewsModel>[].obs;
  var isLoading = false.obs;
  var currentPage = 0.obs;
  final int pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    fetchAndSaveNews();
  }

  Future<void> fetchAndSaveNews() async {
    isLoading(true);
    try {
      final response = await NewsService().getNews();
      if (response != null && response is List<NewsModel>) {
        await DatabaseHelper().deleteAllNews();
        for (var newsItem in response) {
          await DatabaseHelper().insertNews(newsItem);
        }
      }
      fetchNews();
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchNews() async {
    isLoading(true);
    try {
      final response = await DatabaseHelper().getNews(
        limit: pageSize,
        offset: currentPage.value * pageSize,
      );
      if (response.isNotEmpty) {
        news.addAll(response);
        currentPage.value++;
      }
    } finally {
      isLoading(false);
    }
  }
}
