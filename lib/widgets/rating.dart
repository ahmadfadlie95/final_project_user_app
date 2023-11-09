import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}


class _RatingPageState extends State<RatingPage> {
  var userReviews = TextEditingController();
  double _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rating Page"),),
      body: Column(
        children: [
          Center(
            child: RatingBar.builder(
              initialRating: _rating,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating){
                  setState(() {
                    _rating = rating;
                  });
                }),
          ),
          SizedBox(height: 8,),
          Container(
            width: 300,
            height: 100,
            child: TextField(
              controller: userReviews,
              maxLines: 3,
              decoration: InputDecoration(hintText: "Tell people about your experiences", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(height: 35,),
          TextButton(onPressed: (){

            sendRating(userReviews.text, _rating.round()).then((value) {
              if (value.statusCode == 200){
               // Show toast OK
               Navigator.pop(context);
              }
            });

          }, child: Text("Send Review"))
        ],
      ),
    );
  }

  Future<http.Response> sendRating(String comment, int rating) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    return http.post(
      Uri.parse('https://rest-api-spring-ngeu.onrender.com/api/products/4/reviews'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token!}'

      },
      body: jsonEncode(<String, dynamic>{
        'comment': comment,
        'rating': rating,
      }),
    );
  }
}
