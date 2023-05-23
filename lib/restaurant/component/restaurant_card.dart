import 'package:actual_project/common/const/colors.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  //이미지
  final Widget image;
  
  //레스토랑 이름
  final String name;
  
  //레스토랑 태그
  final List<String> tags;
  
  //평점 갯수
  final int ratingCount;
  
  //배송걸리는 시간
  final int deliveryTime;
  
  //배송 비용
  final int deliveryFee;
  
  //평균 평점
  final double rating;

  const RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this. ratingCount,
    required this. deliveryTime,
    required this.deliveryFee,
    required this.rating,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: image,
        ),
        const SizedBox(height: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(name,
            style: TextStyle(
              fontSize:20.0,
              fontWeight: FontWeight.w500,
            ),
            ),
            const SizedBox(height: 8.0),
            Text(
              tags.join(' · '),
              style: TextStyle(
                color:BODY_TEXT_COLOR,
                fontSize: 14.0,
              )
            ),
          ],
        )
      ],
    );
  }
}

