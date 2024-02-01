import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../const/text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool visibility = true;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  height: height * 0.5,
                  width: width,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 113, 65, 146),
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: const AssetImage("img/logo.png"),
                      ))),
              Container(
                  margin: EdgeInsets.only(top: height * 0.45),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "تسجيل الدخول",
                        style: TextStyle(fontSize: height * 0.033),
                      ),
                      TextFieldModel(
                        hint: "البريد الاكتروني",
                        label: "البريد الاكتروني",
                        sufIcon: const Icon(IconlyLight.profile),
                        height: height * 0.07,
                      ),
                      TextFieldModel(
                          hint: "كلمة السر",
                          label: "كلمة السر",
                          height: height * 0.07,
                          sufIcon: visibility
                              ? IconButton(
                                  icon: const Icon(Icons.visibility_outlined),
                                  onPressed: () {
                                    setState(() {});
                                    visibility = false;
                                    print(visibility);
                                  },
                                )
                              : IconButton(
                                  icon:
                                      const Icon(Icons.visibility_off_outlined),
                                  onPressed: () {
                                    setState(() {});
                                    visibility = true;
                                    print(visibility);
                                  },
                                )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
