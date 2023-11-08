import 'package:flutter/foundation.dart';

class Product{
  final String name;
  final int id;
  final String description;
  final double price;
  final String imgUrl;
  final int categoryId;

  Product({
    required this.name,
    required this.id,
    required this.description,
    required this.price,
    required this.imgUrl,
    required this.categoryId
  });
  factory Product.fromJson(Map<String, dynamic>json){
    return Product(name: json["name"], id: json["id"], description: json["description"], price: json["price"], imgUrl: json["imageUrl"], categoryId: json["categoryId"]);
  }
  static List<Product> productsFromJson(dynamic json ){
    var searchResult = json; //kalau ada ["Search"] kena letak, kalau takde, delete je, tengok api
    List<Product> results = List.empty(growable: true);

    if (searchResult != null){

      searchResult.forEach((v)=>{
        results.add(Product.fromJson(v))
      });
      return results;
    }
    return results;
  }
}