import 'package:flutter/material.dart';
import '../Data/Expense.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

//lets build the ChangeNotifier
final ip = "http://192.168.1.9:8000";

class ExpenseProvider extends ChangeNotifier {
  final _storage = FlutterSecureStorage();
  final expenseList = ip + "/api/List";
  // lets define the variable
  List<Expenses> _expenses = [
    Expenses("Transport", 300, 700, 500),
  ];
  List<Expenses> get expenses => _expenses;
  void addExpense(Expenses exp) {
    _expenses.add(exp);
    notifyListeners();
  }

  void incrementRealValue(int index) {
    _expenses[index].realValue += 1;
    notifyListeners();
  }

  void updatePlannedValue(int index, int value) {
    _expenses[index].plannedValue = value;
    notifyListeners();
  }

  void decrementRealValue(int index) {
    _expenses[index].realValue -= 1;
    notifyListeners();
  }

  void inputRealValue(int index, int value) {
    _expenses[index].realValue = value;
    notifyListeners();
  }

  void updateExpense(int index, Expenses exp) {
    _expenses[index] = exp;
    notifyListeners();
  }

  Future<bool> getExpense() async {
    var tokenKey = await _storage.read(key: "tokenKey");
    try {
      final response = await http.get(Uri.parse(expenseList), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $tokenKey'
      });
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        var data = json.decode(response.body) as List;
        this._expenses = data.map((json) => Expenses.fromJson(json)).toList();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      notifyListeners();
      return false;
    }
  }
}
