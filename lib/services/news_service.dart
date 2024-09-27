import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/config/config.dart';
import 'package:news_app/model/news_model.dart';

class NewsService {
  Future<dynamic> getNews() async {
    try {
      String url = "${Config.baseurl}${Config.apiKey}";
      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<dynamic> news = data['articles'];
        List<NewsModel> listNews =
            news.map((e) => NewsModel.fromJson(e)).toList();
        // print(listNews);
        return listNews;
      } else {
        return null;
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'Network Error',
        'Unable to connect to the internet. Please check your connection.\n And old data will be shown here',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
