import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Data/Expense.dart';
import '../screens/ExpenseChart.dart';
import '../screens/createCost.dart';
import '../screens/Account.dart';
import 'dailyCost.dart';
import 'package:provider/provider.dart';

class StartPage extends StatelessWidget {
  StartPage({Key? key}) : super(key: key);
  List<Expenses>? newExpense = [
    Expenses("Transport", 300, 700, 500),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.dashboard)),
                  Tab(icon: Icon(Icons.euro_outlined)),
                  Tab(icon: Icon(Icons.add_chart)),
                  Tab(icon: Icon(Icons.account_box))
                ],
              ),
              title: Text("Welcome", style: GoogleFonts.raleway(fontSize: 20))),
          body: TabBarView(
            children: [
              SingleChildScrollView(child: Expense()),
              CreateCost(),
              DailyCost(),
              Account(),
            ],
          ),
        ),
      ),
    );
  }
}
