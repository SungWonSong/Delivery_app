import 'package:actual_project/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/const/data.dart';
import '../../common/utils/data_utils.dart';

part 'restaurant_detail_model.g.dart';

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {

  //RestaurantModel을 상속해서 받으면 중복도 방지가능
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson(Map<String,dynamic>json)
  => _$RestaurantDetailModelFromJson(json);
}
@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  factory RestaurantProductModel.fromJson(Map<String,dynamic>json)
  => _$RestaurantProductModelFromJson(json);
}
