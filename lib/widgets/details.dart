import 'dart:convert';

import 'package:final_project_user_app/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/product_detail.dart';

class DetailsPage extends StatefulWidget {
  final int productId;

  DetailsPage({required this.productId});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  ProductDetail? product;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  void loadData(){
    fetchProduct().then((value){
      setState(() {
        product = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details Page")),
      body: Column(
        children: [
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => RatingPage()));
          }, child: product == null?Center(child: CircularProgressIndicator()):


          SingleChildScrollView(
            scrollDirection: Axis.vertical, // Specify scrolling dirrection vertical
            child: Column(
              children: [
                Text(product!.name,),
                Text(product!.description,),
                Text("${product!.price}",),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RatingPage()));
                }, child: Text("Add New Review")),
                 Text("User rating"),
                 ListView.builder(
                    shrinkWrap: true, // Lawan kepada expanded / Listview akan jadi sekecil content-nya
                      physics: NeverScrollableScrollPhysics(), // Dalam senario Listview dalam Scrollview, disabled scrolling on Listview
                      itemCount: product!.reviews.length,
                      itemBuilder: (context,index){
                        var currentReview = product!.reviews[index];
                        return Card(
                          child: ListTile(
                            title: Text("${currentReview.comment} - ${currentReview.user}"),
                            subtitle: Text("${currentReview.rating}"),
                          ),
                        );
                      }),
                
              ],
            ),
          )),
        ],
      )
    );
  }
  Future<ProductDetail> fetchProduct() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    final response = await http
        .get(Uri.parse('https://rest-api-spring-ngeu.onrender.com/api/products/${widget.productId}'), //stateful tambah widget depan productId
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token!}'
      },);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ProductDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
