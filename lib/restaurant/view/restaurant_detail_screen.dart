import 'dart:convert';

import 'package:actual_project/common/const/data.dart';
import 'package:actual_project/common/layout/default_layout.dart';
import 'package:actual_project/product/component/product_card.dart';
import 'package:actual_project/restaurant/component/restaurant_card.dart';
import 'package:actual_project/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({required this.id, Key? key}) : super(key: key);

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant/$id',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '불타는 떢복이',
      child: FutureBuilder<Map<String, dynamic>>(
        future: getRestaurantDetail(),
        builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final item = RestaurantDetailModel.fromJson(
            snapshot.data!,
          );
          return CustomScrollView(
            slivers: [
              renderTop(
                model: item,
              ),
              renderLabel(),
              renderProducts(products: item.products),
            ],
          );
        },
      ),
    );
  }
}

SliverPadding renderLabel() {
  return SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    sliver: SliverToBoxAdapter(
      child: Text(
        '메뉴',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

SliverPadding renderProducts({
  required List<RestaurantProductModel> products,
}) {
  return SliverPadding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final model = products[index];

          return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(
                model: model,
              ),
          );
        },
        childCount: products.length,
      ),
    ),
  );
}

SliverToBoxAdapter renderTop({
  required RestaurantDetailModel model,
}) {
  return SliverToBoxAdapter(
    child: RestaurantCard.fromModel(
      model: model,
      isDetail: true,
    ),
  );
}
