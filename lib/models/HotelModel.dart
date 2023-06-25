class HotelModel {
  late String name;
  late String video;
  late String description;
  late String romeCostWithFood;
  late String romeCost;
  late String image;
  late String availableRome;
  late String id;
  late String place;
  late String rate;

  late String createdAt;


  HotelModel({
    required this.name,
    required this.availableRome,
    required this.video,
    required this.description,
    required this.romeCostWithFood,
    required this.romeCost,
    required this.image,
    required this.id,
    required this.place,
    required this.rate,
    required this.createdAt,
  });

  HotelModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    availableRome = json['availableRome'];
    video = json['video'];
    description = json['description'];
    romeCostWithFood = json['romeCostWithFood'];
    romeCost = json['romeCost'];
    image = json['image'];
    id = json['id'];
    createdAt = json['createdAt'];
    place = json['place'];
    rate = json['rate'];


  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'availableRome': availableRome,
      'video': video,
      'description': description,
      'romeCostWithFood': romeCostWithFood,
      'romeCost': romeCost,
      'image': image,
      'id': id,
      'createdAt': createdAt,
      'place': place,
      'rate': rate,

    };
  }
}