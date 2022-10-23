import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget MyImageAppBar() {
  return AppBar(
    backgroundColor: Color(0xFF162465),
    title: Text(
      '나의 즐겨찾기',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
  );
}