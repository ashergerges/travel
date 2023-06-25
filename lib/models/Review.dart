class ReviewModel {
  late String name;
  late String image;
  late String id;
  late String review;
  late String createdAt;


  ReviewModel({
    required this.name,
    required this.image,
    required this.id,
    required this.review,
    required this.createdAt,
  });

  ReviewModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    id = json['id'];
    createdAt = json['createdAt'];
    review = json['review'];



  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,

      'image': image,
      'id': id,
      'createdAt': createdAt,
      'review': review,


    };
  }
}