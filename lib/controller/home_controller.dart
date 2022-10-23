import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;


class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();

  final String client_id = 'q06uP1ZqopkDJZuahHwQ';
  final String client_secret = 'ipr1csrtAj';

  final searchText = ''.obs;
  final content = [].obs;

  void searchTextUpdate(String value) {
    searchText.value = value;
  }

  void search() async {
    http.Response response = await http.get(
        Uri.parse(
            "https://openapi.naver.com/v1/search/image?query=${searchText}&display=100&sort=sim"),
        headers: <String, String>{
          'X-Naver-Client-Id': client_id,
          'X-Naver-Client-Secret': client_secret
        });
    var resBody = jsonDecode(utf8.decode(response.bodyBytes));
    content.value = resBody['items'];
  }
}