import 'dart:convert';

import 'package:final_project_user_app/widgets/details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List <Product>  productList = [
    // {
    //   "name": "Nama hotel",
    //   "address": "Address",
    // },
    // {
    //   "name": "Nama hotel",
    //   "address": "Address",
    // },
    // {
    //   "name": "Nama hotel",
    //   "address": "Address",
    // }
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  void loadData(){
    fetchProducts().then((value){
     setState(() {
       productList = value;
     });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomePage"),),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          // return Container(
          //   height: 50,
          //   color: Colors.amber,
          //   child: Center(child: Text(hotelList[index]["name"]!)),
          // );
          return Card(
            child: ListTile(
              leading: Image.network('https://pix8.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?ca=6&ce=1&s=1024x768'),
              title: Text(productList[index].name),
              subtitle: Text("RM${productList[index].price}"),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(productId: productList[index].id)
                ),);
              }
            ),
          );
        },
      ),
    );
  }
  Future<List<Product>> fetchProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    final response = await http
        .get(Uri.parse('https://rest-api-spring-ngeu.onrender.com/api/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token!}'
      },);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Product.productsFromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
