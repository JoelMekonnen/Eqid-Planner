import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Data/Expense.dart';
import 'package:provider/provider.dart';
import '../providers/ExpenseProvider.dart';

class Expense extends StatelessWidget {
  //

  Expense();

  @override
  Widget build(BuildContext context) {
    final expenses = Provider.of<ExpenseProvider>(context);
    expenses.getExpense();
    return Consumer<ExpenseProvider>(builder: (context, expense, child) {
      return Column(
        children: [
          Container(
            color: Color.fromRGBO(255, 255, 255, 1),
            width: double.infinity,
            child: Image.asset(
              "Images/dashboard.jpg",
              height: 300,
              width: double.infinity,
              filterQuality: FilterQuality.high,
            ),
          ),
          Column(
              children: expense.expenses
                  .asMap()
                  .entries
                  .map(
                    (expense) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        width: double.infinity,
                        height: 100,
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 6.0)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    expense.value.realValue.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                  Text("Expense",
                                      style: GoogleFonts.raleway(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                            ),
                            Text(expense.value.expenseName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )),
                            Container(
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    expense.value.plannedValue.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                  Text("Plan",
                                      style: GoogleFonts.raleway(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                            (expense.value.plannedValue <=
                                    expense.value.realValue)
                                ? Icon(Icons.thumb_down, color: Colors.black)
                                : Icon(Icons.thumb_up, color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()),
        ],
      );
    });
  }
}
