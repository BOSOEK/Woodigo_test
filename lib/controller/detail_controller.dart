import 'package:get/get.dart';

import '../domain/model.dart';
import '../domain/repository/database_helper.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find<DetailController>();

  final check = 0.obs;
  final imageUrl = ''.obs;

  void addImage() async {
    if(DetailController.to.check.value == 0) {
      DetailController.to.check.value = 1;
      await DatabaseHelper.instance.add(
        NaverSearch(name: DetailController.to.imageUrl.value),
      );
    }
  }
}