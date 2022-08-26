import 'package:restaurant/model/MenuItemModel.dart';
import 'package:restaurant/model/MenuModel.dart';

class RestaurantModel {
  String id;
  String name;
  String description;
  String city;
  num rating;
  String pictureUrl;
  MenuModel menu;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.rating,
    required this.pictureUrl,
    required this.menu,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> map) {
    var menu = map['menus'] as Map<String, dynamic>;

    return RestaurantModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      city: map['city'],
      rating: map['rating'],
      pictureUrl: map['pictureId'],
      menu: MenuModel(
          drinks: (menu['drinks'] as List<dynamic>).map((e) => MenuItemModel(name: e['name'])).toList(),
          foods: (menu['foods'] as List<dynamic>).map((e) => MenuItemModel(name: e['name'])).toList(),
      ),
    );
  }
}
