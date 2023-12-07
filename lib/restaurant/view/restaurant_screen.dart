import 'package:actual_project/common/const/data.dart';
import 'package:actual_project/restaurant/component/restaurant_card.dart';
import 'package:actual_project/restaurant/model/restaurant_model.dart';
import 'package:actual_project/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.post(
      'http://$ip/auth/login',
      options: Options(
        headers: {
          'authorization': 'Basic $accessToken',
        },
      ),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                  //Circular....tor는 페이지 넘어갈때 중앙에 로딩잠깐 뜨게 하는 것
                );
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final item = snapshot.data![index];
                  final pItem = RestaurantModel.fromJson(json:item
                  ); //fromJson이라는 factory constructor를 사용하여 modeling 적용
                  //parsed
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RestaurantDetailScreen(
                          id: pItem.id,
                        )),
                      );
                    },
                    //나중에 go-router를 사용하지만 지금은 이렇게 Navigator사용
                    child: RestaurantCard.fromModel(model: pItem,
                    ),
                  ); //fromModel이라는 factory constructor를 사용하여 modeling 적용
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 16.0);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
