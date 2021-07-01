//import 'package:flutter/material.dart';

class Expenses {
  String? _expenseName;
  int? _plannedValue;
  int? _realValue;
  int? _income;

  String get expenseName => _expenseName!;
  int get plannedValue => _plannedValue!;
  int get realValue => _realValue!;
  int get income => _income!;

  set expenseName(String value) {
    _expenseName = value;
  }

  set plannedValue(int value) {
    _plannedValue = value;
  }

  set realValue(int value) {
    _realValue = value;
  }

  Expenses(String expenseName, int plannedValue, int realValue, int income) {
    _expenseName = expenseName;
    _plannedValue = plannedValue;
    _realValue = realValue;
    _income = income;
  }
  Expenses.fromJson(json) {
    _expenseName = json["expenseName"];
    _plannedValue = json["plannedValue"];
    _realValue = json["realValue"];
    _income = json["income"];
  }
}
