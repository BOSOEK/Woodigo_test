import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/home_controller.dart';
import '../../my_image/my_image.dart';

PreferredSizeWidget HomeAppBar(Size size) {
  return AppBar(
    toolbarHeight: 180,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: const Radius.circular(30),
      ),
    ),
    flexibleSpace: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: const Color(0xFF162465),
          borderRadius: BorderRadius.vertical(
            bottom: const Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Search',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Row(
              children: [
                const Text(
                  'for ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  'everything',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: size.width - 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            HomeController.to.search();
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.pinkAccent,
                            size: 28,
                          )),
                      new Flexible(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            HomeController.to.search();
                          },
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            HomeController.to.searchTextUpdate(value);
                          },
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            fillColor: Colors.transparent,
                            filled: true,
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFD1D9E6),
                            ),
                            labelStyle:
                            TextStyle(color: Color(0xff878E97)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Get.to(() => MyImagePage());
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.pinkAccent,
                        size: 24,
                      )),
                ),
              ],
            ),
          ],
        )),
  );
}