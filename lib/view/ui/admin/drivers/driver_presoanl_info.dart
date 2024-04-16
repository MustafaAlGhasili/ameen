import 'package:ameen/model/driver.dart';
import 'package:ameen/view/ui/widget/custom_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DriverPInfo extends StatelessWidget {
  final DriverModel driver;

  const DriverPInfo({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          centerTitle: true,
          title: const Text("معلومات السائق الشخصية"),
        ),
        body: SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1.3),
                    margin: EdgeInsets.only(top: height * 0.035),
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: width * 0.19,
                      child: CachedNetworkImage(
                        imageUrl: driver.photo ?? " ",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Image(image: AssetImage("img/st1.png")),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                    child: Text(
                      "الاسم الاول",
                      style: TextStyle(fontSize: width * 0.037),
                    ),
                  ),
                  CustomContainer(text: driver.fName),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                    child: Text(
                      "الاسم الاخير",
                      style: TextStyle(fontSize: width * 0.037),
                    ),
                  ),
                  CustomContainer(text: driver.lName),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                    child: Text(
                      "رقم الأحوال",
                      style: TextStyle(fontSize: width * 0.037),
                    ),
                  ),
                  CustomContainer(text: driver.nationalId),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                    child: Text(
                      "رقم التواصل ",
                      style: TextStyle(fontSize: width * 0.037),
                    ),
                  ),
                  CustomContainer(text: driver.phone),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                    child: Text(
                      "تاريخ الميلاد",
                      style: TextStyle(fontSize: width * 0.037),
                    ),
                  ),
                  CustomContainer(text: driver.driverBDate),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                    child: Text(
                      "فصيلة الدم ",
                      style: TextStyle(fontSize: width * 0.037),
                    ),
                  ),
                  CustomContainer(text: driver.blood),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                    child: Text(
                      "رقم الباص ",
                      style: TextStyle(fontSize: width * 0.037),
                    ),
                  ),
                  CustomContainer(text: driver.busId),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
