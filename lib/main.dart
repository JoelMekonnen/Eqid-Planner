import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/startpage.dart';
import 'package:provider/provider.dart';
import 'providers/ExpenseProvider.dart';
import 'providers/AuthProvider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ExpenseProvider()),
        ChangeNotifierProvider.value(value: AuthProvider()),
      ],
      child: MaterialApp(
        title: "App",
        debugShowCheckedModeBanner: false,
        home: EqidPlanner(),
      ),
    ));

class EqidPlanner extends StatefulWidget {
  const EqidPlanner({Key? key}) : super(key: key);

  @override
  _EqidPlannerState createState() => _EqidPlannerState();
}

class _EqidPlannerState extends State<EqidPlanner> {
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eqid-Planner',
      home: Scaffold(
        body: SingleChildScrollView(
          child: contentCol(context),
        ),
      ),
    );
  }

  Column contentCol(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final expense = Provider.of<ExpenseProvider>(context);
    var resp = [];
    TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Expanded(
                child: Image.asset("Images/HeaderImage.jpg",
                    width: 400, height: 300))
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                  width: double.infinity,
                  color: Colors.white24,
                  margin: EdgeInsets.only(top: 30, bottom: 30),
                  alignment: Alignment.center,
                  child: Text("Eqid-Plan-Save",
                      style: GoogleFonts.raleway(fontSize: 30))),
            )
          ],
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.only(left: 50, right: 50),
                child: TextField(
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(30, 30),
                        ),
                      ),
                    ),
                    controller: _username),
              ),
              Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                margin: EdgeInsets.only(top: 30),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(fontSize: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(30, 30),
                      ),
                    ),
                  ),
                  controller: _password,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    margin: EdgeInsets.only(top: 50, right: 60),
                    child: ElevatedButton(
                      child: Text("Log in"),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.cyan),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(50, 50)))),
                      ),
                      onPressed: () async {
                        final form = formKey.currentState;
                        if (form!.validate()) {
                          form.save();
                          resp = await auth.userLogin(
                              _username.value.text.toString(),
                              _password.value.text.toString());
                        }
                        print(resp);
                        if (resp[0]) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StartPage(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 160,
                    height: 50,
                    margin: EdgeInsets.only(top: 80, left: 20),
                    child: TextButton(
                      child: Text("Create New Account"),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(50, 50)))),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
