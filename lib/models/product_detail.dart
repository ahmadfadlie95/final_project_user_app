import 'package:final_project_user_app/models/review.dart';
import 'package:flutter/foundation.dart';

class ProductDetail{
  final String name;
  final int id;
  final String description;
  final double price;
  final String imgUrl;
 // final int categoryId;
  final List<Review> reviews;

  ProductDetail({
    required this.name,
    required this.id,
    required this.description,
    required this.price,
    required this.imgUrl,
    //required this.categoryId
    required this.reviews
  });
  factory ProductDetail.fromJson(Map<String, dynamic>json){
    return ProductDetail(name: json["name"], id: json["id"], description: json["description"],
        price: json["price"],
        imgUrl: json["imageUrl"],
        reviews:Review.reviewsFromJson(json["reviews"])
    );
  }
}