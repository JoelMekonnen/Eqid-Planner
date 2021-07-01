import 'package:eqidplanner/screens/ExpenseChart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Data/Expense.dart';
import 'package:provider/provider.dart';
import '../providers/ExpenseProvider.dart';

class CreateCost extends StatefulWidget {
  CreateCost({Key? key}) : super(key: key);

  @override
  _CreateCostState createState() => _CreateCostState();
}

class _CreateCostState extends State<CreateCost> {
  final expenseController = TextEditingController();
  final plannedValue = TextEditingController();
  final realValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [expenseList(context)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          createDialog(context);
        },
      ),
    );
  }

  void createDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<ExpenseProvider>(
            builder: (context, exp, child) {
              return AlertDialog(
                title: Text("Create Expense"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add),
                        hintText: "Expense title",
                        hintStyle: GoogleFonts.raleway(fontSize: 15),
                      ),
                      controller: expenseController,
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.add),
                        hintText: "Planned value",
                        hintStyle: GoogleFonts.raleway(fontSize: 15),
                      ),
                      controller: plannedValue,
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      child: Text("Create"),
                      onPressed: () {
                        Expenses newExp = new Expenses(
                            expenseController.text.toString(),
                            int.parse(plannedValue.text.toString()),
                            0,
                            0);
                        exp.addExpense(newExp);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  Widget expenseList(BuildContext context) {
    return Consumer<ExpenseProvider>(builder: (context, exp, child) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: exp.expenses
              .asMap()
              .entries
              .map(
                (expense) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(left: 10, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 6.0)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(expense.value.expenseName,
                          style: GoogleFonts.raleway(fontSize: 20)),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Icon(Icons.edit),
                              onPressed: () {
                                editDialog(context, expense.key);
                              },
                            ),
                            TextButton(
                              child: Icon(Icons.delete),
                              onPressed: () {},
                            ),
                            TextButton(
                              child: Icon(Icons.upload),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList());
    });
  }

  void editDialog(BuildContext context, int index) {
    final plannedValue = TextEditingController();
    final expenseController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<ExpenseProvider>(builder: (context, exp, child) {
            return AlertDialog(
              title: Text("Create Expense"),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.add),
                    hintText: exp.expenses[index].expenseName,
                    hintStyle: GoogleFonts.raleway(fontSize: 15),
                  ),
                  controller: expenseController,
                ),
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.add),
                    hintText: exp.expenses[index].plannedValue.toString(),
                    hintStyle: GoogleFonts.raleway(fontSize: 15),
                  ),
                  controller: plannedValue,
                ),
                ElevatedButton(
                    child: Icon(Icons.update),
                    onPressed: () {
                      Expenses val = new Expenses(
                          expenseController.text.toString(),
                          int.parse(plannedValue.text.toString()),
                          0,
                          0);
                      exp.updateExpense(index, val);
                    })
              ]),
            );
          });
        });
  }
}
