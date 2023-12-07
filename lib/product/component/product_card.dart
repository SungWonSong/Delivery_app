import 'package:actual_project/common/const/colors.dart';
import 'package:actual_project/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    Key? key,
  }) : super(key: key);

  factory ProductCard.fromModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // 이걸 써도 spaceBetween이 안먹는 경우가 있다. Column이 이미지의 height만큼 표시가 안된다.
              // 따라서 Row에 위젯 => IntrinsicHeight(높이최대)로 감싼다.
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                Text(
                  detail,
                  overflow: TextOverflow.ellipsis,
                  // Text의 줄이 바뀌었을때 글이 넘친다고 가정하면 ellipsis(...), clip(짜른다), visible(보이게) 등
                  maxLines: 2,
                  style: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
                ),
                Text(
                  '$price',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
