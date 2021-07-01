import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/ExpenseProvider.dart';
import '../providers/AuthProvider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthProvider>(context);
    userData.detials();
    return Container(
        child: Column(
      children: [
        Text(userData.username),
      ],
    ));
  }
}
