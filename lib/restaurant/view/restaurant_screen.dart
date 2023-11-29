import 'package:actual_project/common/const/data.dart';
import 'package:actual_project/restaurant/component/restaurant_card.dart';
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
                return Container();
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                final item = snapshot.data![index];

                  return RestaurantCard(
                    image: Image.network(
                      'http://$ip${item['thumbUrl']}',
                          fit: BoxFit.cover,
                    ),
                    name: item['name'],
                    tags: List<String>.from(item['tags']),
                    //오류 List<String>으로 받아야되는데 dynamic으로 되어있어서, List<String>.from을 통해 변환

                    ratingsCount: item['ratingsCount'],
                    deliveryTime: item['deliveryTime'],
                    deliveryFee: item['deliveryFee'],
                    ratings: item['ratings'],
                  );
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
