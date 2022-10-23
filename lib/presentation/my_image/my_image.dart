import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woodigo_test/presentation/my_image/components/my_image_result.widget.dart';

import '../../domain/model.dart';
import '../../domain/repository/database_helper.dart';
import 'components/appbar.dart';


class MyImagePage extends StatelessWidget {
  MyImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyImageAppBar(),
      body: Center(
        child: FutureBuilder<List<NaverSearch>>(
          future: DatabaseHelper.instance.getGroceries(),
          builder:
              (BuildContext context, AsyncSnapshot<List<NaverSearch>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Loading'),
              );
            }
            return snapshot.data!.isEmpty
                ? Center(child: Text('선택하신 즐겨찾기가 없습니다!'))
                : ListView(
              physics: BouncingScrollPhysics(),
              children: snapshot.data!.map((naverSearch) {
                return MyImageResultWidget(naverSearch: naverSearch);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}