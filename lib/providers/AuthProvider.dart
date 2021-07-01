import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Data/Expense.dart';
import '../Data/userModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

enum Status {
  Uninitialized,
  Unauthenticated,
  Authentcating,
  Authenticated,
  Failed
}
final ip = "http://192.168.1.9:8000";

class AuthProvider extends ChangeNotifier {
  UserModel _model = UserModel();
  Status _status = Status.Uninitialized;
  final _storage = FlutterSecureStorage();
  var tokenKey = "";
  final loginURL = ip + "/api/rest-auth/login/";
  final userURL = ip + "/api/user/";

  String? _username = "";
  String get username => _username!;
  Future<List<dynamic>> userLogin(String username, String password) async {
    final Map<String, dynamic> loginData = {
      "username": username,
      "password": password,
    };
    this._status = Status.Authentcating;
    notifyListeners();
    try {
      final response = await http.post(Uri.parse(loginURL),
          body: json.encode(loginData),
          headers: {'Content-Type': 'application/json'});
      // the response is valid
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var data = json.decode(response.body);
        print(data);
        await this._storage.write(key: "tokenKey", value: data['key']);
        final resp = await http.get(Uri.parse(userURL), headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${data["key"]}'
        });
        var data1 = json.decode(resp.body) as List;
        print(data1);
        this._model = UserModel.fromJson(data1[0]);
        print(_model.username);
        await this._storage.write(key: "username", value: this._model.username);
        await this._storage.write(key: "email", value: this._model.email);
        await this
            ._storage
            .write(key: "firstname", value: this._model.fistName);
        await this._storage.write(key: "lastname", value: this._model.lastName);
        await this
            ._storage
            .write(key: "description", value: _model.description);
        // _status = Status.Authenticated;
        return [true];
      }
      // request code 400
      else if (response.statusCode == 400) {
        _status = Status.Unauthenticated;
        notifyListeners();
        return [false, json.decode(response.body)];
      } else {
        return [false];
      }
    } catch (e) {
      print(e);
      _status = Status.Failed;
      notifyListeners();
      return [false];
    }
  }

  void detials() async {
    _username = await this._storage.read(key: "username");
    notifyListeners();
  }
}
