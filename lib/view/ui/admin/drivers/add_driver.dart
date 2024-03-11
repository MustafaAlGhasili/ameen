import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:ameen/view/ui/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class AddDriver extends StatelessWidget {
  const AddDriver({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          centerTitle: true,
          title: const Text("اضافة سائق جديد"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                child: TextFieldModel(
                  text: "الاسم الاول",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                child: TextFieldModel(
                  text: "الاسم الأخير",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                child: TextFieldModel(
                  text: "رقم الاحوال",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                child: TextFieldModel(
                  sufIcon: Icon(IconlyLight.calendar),
                  text: "تاريخ الميلاد",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                child: TextFieldModel(
                  sufIcon: Icon(Icons.keyboard_arrow_down),
                  text: "فصيلة الدم",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                child: TextFieldModel(
                  sufIcon: Icon(Icons.keyboard_arrow_down),
                  text: "ادراج صورة من رخصة القيادة",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                child: TextFieldModel(
                  text: "رقم الباص ",
                ),
              ),
              ButtonModel(
                content: "حفط",
                rowMainAxisAlignment: MainAxisAlignment.center,
                backColor: PRIMARY_COLOR,
                height: height * 0.06,
                hMargin: width * 0.07,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
