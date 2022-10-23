import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:woodigo_test/presentation/home/components/appbar.dart';

import '../../controller/home_controller.dart';
import 'components/home_result.widget.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: HomeAppBar(size),
        body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Search result',
                      style: const TextStyle(
                          fontSize: 22,
                          color: Color(0xFF162465),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 14,),
                    HomeResultWidget(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}