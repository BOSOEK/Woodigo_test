import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/model.dart';

class MyImageResultWidget extends StatelessWidget {
  NaverSearch naverSearch;
  MyImageResultWidget({Key? key, required this.naverSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl:"${naverSearch.name}",
            placeholder:(context,url)=>Center(
              child: const CircularProgressIndicator(),
            ),
            errorWidget:(context,url,error)=>Image.asset(
              'assets/error-image-generic.png',
              fit: BoxFit.cover,
              width: size.width - 60,
              height: size.width - 60,
            ),
            width: size.width - 60,
            height: size.width - 60,
          ),
        ),
      ),
    );
  }
}
