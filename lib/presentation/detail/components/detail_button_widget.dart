import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/detail_controller.dart';

class DetailButtonWidget extends StatelessWidget {
  const DetailButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF162465),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
          () => IconButton(
            onPressed: () async {
              DetailController.to.addImage();
            },
            icon: DetailController.to.check.value == 1 ? const Icon(
              Icons.favorite,
              color: Colors.pinkAccent,
              size: 24,
            ) : const Icon(
              Icons.favorite_border,
              color: Colors.pinkAccent,
              size: 24,
            ),
          )
      ),
    );
  }
}
