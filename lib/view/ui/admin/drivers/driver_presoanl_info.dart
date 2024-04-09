import 'package:ameen/model/driver.dart';
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
                    padding: const EdgeInsets.all(1),
                    margin: EdgeInsets.only(top: height * 0.035),
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: width * 0.2,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("الاسم الاول"),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text(driver.fName),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("الاسم الاخير"),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text(driver.lName),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("رقم الأحوال"),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text(driver.nationalId),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("رقم التواصل "),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child:  Text(driver.phone),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("تاريخ الميلاد"),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child:  Text(driver.driverBDate),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("فصيلة الدم "),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child:  Text(driver.blood),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const Text("رقم الباص "),
                  ),
                  Container(
                    padding: EdgeInsets.all(13),
                    width: width,
                    height: height * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black)),
                    child: Text(driver.busId),
                  ),
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
