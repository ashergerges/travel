class UserModel {
  late String name;
  late String email;
  late String password;
  late String phone;
  late String image;
  late String id;


  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.image,
    required this.id,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
    id = json['id'];


  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
      'id': id,

    };
  }
}