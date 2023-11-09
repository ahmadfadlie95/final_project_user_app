class Review {
  final String comment;
  final int rating;
  final String user;
  
  Review({required this.comment, required this.rating, required this.user});
  
  factory Review.fromJson(Map<String,dynamic> json){
    return Review(comment: json["review"], rating: json["rating"], user: "${json["user"]["firstname"]} ${json["user"]["lastname"]}");
  }
  static List<Review> reviewsFromJson(dynamic json ){
    var searchResult = json; //kalau ada ["Search"] kena letak, kalau takde, delete je, tengok api
    List<Review> results = List.empty(growable: true);

    if (searchResult != null){

      searchResult.forEach((v)=>{
        results.add(Review.fromJson(v))
      });
      return results;
    }
    return results;
  }

}