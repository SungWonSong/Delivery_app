import 'package:json_annotation/json_annotation.dart';

import '../../common/const/data.dart';
import '../../common/utils/data_utils.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive, //high, medium,low
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  //from / to 존재하며 JSON으로부터 변경이되야되는 함수를 만들어 적용한후 터미널에 (flutter pub run build_runner) build하면 g.dart파일도 변형
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  // json_serializable의 annotaion에 의하여 이부분이 우리가 작성했던 json값에 넣어주는 것이 g.dart파일로 생긴다.
  // g.dart파일에는 modeling된 값과 instance의 값이 둘다 존재한다. 밑은 자동화 코드.

  factory RestaurantModel.fromJson(Map<String, dynamic> json)
  => _$RestaurantModelFromJson(json);
  // json으로부터 instance를 만드는 것

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
  // json으로 instance를 변환하는 것


//   factory RestaurantModel.fromJson({
//     required Map<String, dynamic> json,
//     // json이라고 하면은 Map<String,dynamic>으로 일반적으로 생각하기
//   }) {
//     return RestaurantModel(
//         id: json['id'],
//         name: json['name'],
//         thumbUrl: 'http://$ip${json['thumbUrl']}',
//         tags: List<String>.from(json['tags']),
//     priceRange: RestaurantPriceRange.values
//         .firstWhere((e) => e.name == json['priceRange']),
//     ratings: json['ratings'],
//     ratingsCount: json['ratingsCount'],
//     deliveryTime: json['deliveryTime'],
//     deliveryFee: json['deliveryFee'],
//     );
//   }
//
}

//code generation이 많이 발생하는 project일 경우 flutter pub run build_runner watch를 사용하면 계속 변경될때마다 리로드해준다.