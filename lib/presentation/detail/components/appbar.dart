import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget DetailAppBar() {
  return AppBar(
    backgroundColor: const Color(0xFF162465),
    title: const Text(
      '자세히 보기',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: true,
  );
}