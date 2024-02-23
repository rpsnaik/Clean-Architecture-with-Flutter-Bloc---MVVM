import 'package:zomato_clone/features/restarunts/domain/entities.dart';

class RestaruntModel extends RestaruntEntity {
  RestaruntModel(
      {required super.name,
      required super.cuisine,
      required super.imageUrl,
      required super.location});

  factory RestaruntModel.fromJson(Map<String, dynamic> data) {
    return RestaruntModel(
        name: data["name"],
        cuisine: data["cuisine"],
        imageUrl: data["image_url"],
        location: data["location"]);
  }
}
