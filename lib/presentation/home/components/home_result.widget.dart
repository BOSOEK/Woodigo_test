import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/home_controller.dart';
import '../../detail/detail.dart';

class HomeResultWidget extends StatelessWidget {
  HomeResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Theme(
        data: ThemeData(
          primarySwatch: Colors.blue,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
            () => ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: HomeController.to.content.value.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: InkWell(
                onTap: () {
                  Get.to(() => DetailPage(imageUrl: '${HomeController.to.content.value[index]['link']}',));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: size.width - 60,
                    height: size.width - 60,
                    imageUrl:"${HomeController.to.content.value[index]['link']}",
                    placeholder:(context,url)=>Center(
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget:(context,url,error)=>Image.asset(
                      'assets/error-image-generic.png',
                      width: size.width - 60,
                      height: size.width - 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        )
        ),
    );
  }
}
