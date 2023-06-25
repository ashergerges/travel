class TouristModel {
  late String name;
  late String video;
  late String description;
  late String image;
  late String id;
  late String place;
  late String rate;
  late String createdAt;


  TouristModel({
    required this.name,
    required this.video,
    required this.description,
    required this.image,
    required this.id,
    required this.place,
    required this.rate,
    required this.createdAt,
  });

  TouristModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    video = json['video'];
    description = json['description'];
    image = json['image'];
    id = json['id'];
    createdAt = json['createdAt'];
    place = json['place'];
    rate = json['rate'];


  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,

      'video': video,
      'description': description,
      'image': image,
      'id': id,
      'createdAt': createdAt,
      'place': place,
      'rate': rate,

    };
  }
}