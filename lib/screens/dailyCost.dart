import 'package:flutter/material.dart';
import '../Data/Expense.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/ExpenseProvider.dart';

class DailyCost extends StatefulWidget {
  DailyCost({Key? key}) : super(key: key);

  @override
  _DailyCostState createState() => _DailyCostState();
}

class _DailyCostState extends State<DailyCost> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: updateForm());
  }

  List<TextEditingController>? _controllers = [];
  Widget updateForm() {
    return Consumer<ExpenseProvider>(builder: (context, exp, child) {
      for (var elems in exp.expenses) {
        _controllers!.add(new TextEditingController());
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: exp.expenses
            .asMap()
            .entries
            .map((expense) => Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(expense.value.expenseName + ":",
                          style: GoogleFonts.montserrat(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                      TextButton(
                        child: Icon(
                          Icons.remove_circle,
                        ),
                        onPressed: () {
                          exp.decrementRealValue(expense.key);
                        },
                      ),
                      Container(
                        width: 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: expense.value.realValue.toString(),
                            hintStyle: GoogleFonts.raleway(fontSize: 15),
                          ),
                          controller: this._controllers![expense.key],
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            exp.inputRealValue(
                                expense.key,
                                int.parse(this
                                    ._controllers![expense.key]
                                    .text
                                    .toString()));
                          },
                        ),
                      ),
                      TextButton(
                        child: Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          exp.incrementRealValue(expense.key);
                        },
                      ),
                    ],
                  ),
                ))
            .toList(),
      );
    });
  }
}
