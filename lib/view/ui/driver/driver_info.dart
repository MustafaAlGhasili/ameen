import 'package:ameen/model/driver.dart';
import 'package:flutter/material.dart';
import '../../../services/LocalStorageService.dart';

class DriverInfo extends StatelessWidget {
  const DriverInfo({super.key});

  @override
  Widget build(BuildContext context) {
    DriverModel? driver;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: FutureBuilder<DriverModel?>(
      future: LocalStorageService.getDriver(),
      builder: (context, snapshot) {
        driver = snapshot.data;
        // print("parent ${parent!.fName}");
        // print(parent!.fName);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("الاسم الاول"),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(driver!.fName),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("الاسم الاخير"),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(driver!.lName),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("رقم الأحوال"),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(driver!.nationalId),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("رقم التواصل "),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(driver!.phone),
              ),
              // SizedBox(
              //   height: height * 0.03,
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Text("تاريخ الميلاد"),
              // ),
              // Container(
              //   padding: const EdgeInsets.all(13),
              //   width: width,
              //   height: height * 0.06,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       border: Border.all(color: Colors.black)),
              //   child: Text(parent!.email),
              // ),
              SizedBox(
                height: height * 0.03,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("رقم الباص "),
              ),
              Container(
                padding: const EdgeInsets.all(13),
                width: width,
                height: height * 0.06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Text(driver!.phone),
              ),
            ],
          );
        } else {
          return Container(
            color: Colors.blue,
            height: 100,
          );
        }
      },
    ));
  }
}
