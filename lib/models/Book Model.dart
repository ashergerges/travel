class BookModel {
  late String name;
  late String user;
  late String image;
  late String numberRomeWith;
  late String numberRome;
  late String id;
  late String idHotel;
  late String idUser;
  late String totalCost;
  late String startDay;
  late String endDay;
  late String createdAt;


  BookModel({
    required this.name,
    required this.image,
    required this.numberRomeWith,
    required this.numberRome,
    required this.totalCost,
    required this.startDay,
    required this.endDay,
    required this.id,
    required this.createdAt,
    required this.user,
    required this.idHotel,
    required this.idUser,
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    user = json['user'];
    idHotel = json['idHotel'];
    numberRomeWith = json['numberRomeWith'];
    numberRome = json['numberRome'];
    totalCost = json['totalCost'];
    startDay = json['startDay'];
    endDay = json['endDay'];
    image = json['image'];
    id = json['id'];
    createdAt = json['createdAt'];
    idUser = json['idUser'];



  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'user': user,
      'numberRomeWith': numberRomeWith,
      'numberRome': numberRome,
      'totalCost': totalCost,
      'startDay': startDay,
      'endDay': endDay,
      'image': image,
      'id': id,
      'createdAt': createdAt,
      'idHotel': idHotel,
      'idUser': idUser,


    };
  }
}