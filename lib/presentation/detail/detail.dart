import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/detail_controller.dart';
import 'components/appbar.dart';
import 'components/detail_button_widget.dart';

class DetailPage extends StatelessWidget {
  final String imageUrl;

  const DetailPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DetailController());
    DetailController.to.check.value = 0;
    DetailController.to.imageUrl.value = imageUrl;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: DetailAppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:"$imageUrl",
                  placeholder:(context,url)=>Center(
                    child: const CircularProgressIndicator(),
                  ),
                  errorWidget:(context,url,error)=>Image.asset(
                    'assets/error-image-generic.png',
                    width: size.width - 40,
                    height: size.width - 40,
                    fit: BoxFit.cover,
                  ),
                  width: size.width - 40,
                  height: size.width - 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 60,),
              DetailButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}