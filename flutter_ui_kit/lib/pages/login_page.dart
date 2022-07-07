import 'package:fitness_ui_kit/authenthication_service.dart';
import 'package:fitness_ui_kit/pages/home_page.dart';
import 'package:fitness_ui_kit/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _passwordVisible;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                height: (size.height - 60) * 0.5,
                child: Column(
                  children: [
                    Text(
                      "GoActive",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: bgTextField,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.envelope,
                              color: black.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: TextField(
                                controller: emailController,
                                cursorColor: black.withOpacity(0.5),
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    border: InputBorder.none),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: bgTextField,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Icon(
                              LineIcons.lock,
                              color: black.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: TextField(
                                controller: passwordController,
                                cursorColor: black.withOpacity(0.5),
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    border: InputBorder.none),
                                obscureText: !_passwordVisible,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  LineIcons.eyeAlt,
                                  color: black.withOpacity(0.5),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: thirdColor),
                onPressed: () {
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(
                  // builder: (context) => const HomePage()));
                  context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                },
                child: Text("Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
