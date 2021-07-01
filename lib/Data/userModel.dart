class UserModel {
  String? _username;
  String? _description;
  String? _email;
  String? _firstName;
  String? _lastName;

  String get username => _username!;
  String get description => _description!;
  String get email => _email!;
  String get fistName => _firstName!;
  String get lastName => _lastName!;

  UserModel.fromJson(json) {
    _username = json["username"];
    _email = json["email"];
    _description = json["description"];
    _firstName = json["first_name"];
    _lastName = json["last_name"];
  }
  UserModel();
}
