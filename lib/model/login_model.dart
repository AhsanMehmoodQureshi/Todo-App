
class LoginModel {
  LoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
  });
  late final int id;
  late final String username;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String gender;
  late final String image;
  late final String token;

  LoginModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['gender'] = gender;
    _data['image'] = image;
    _data['token'] = token;
    return _data;
  }
}