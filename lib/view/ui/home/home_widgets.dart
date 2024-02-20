import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Positioned(
            // top: 100,
            child: Container(
              alignment: Alignment.center,
              height: height * 0.5,
              width: width,
              color: const Color.fromARGB(255, 113, 65, 146),
              child: Image(
                fit: BoxFit.scaleDown,
                gaplessPlayback: false,
                width: width * 0.7,
                image: const AssetImage("img/logo.png"),
              ),
            ),
          ),
          Positioned(
            top: height * 0.45,
            child: Container(
              width: width,
              height: height * 0.5,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )),
              child: Row(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      // duration: Duration(seconds: 1),
      width: width * 0.5,
      height: height * 0.5,
      alignment: Alignment.center,
      color: Colors.blue,
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black45,
                  spreadRadius: 10,
                  blurRadius: 3,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.bottomCenter,
            height: height * 0.07,
            width: width,
            child: Text(
              "الأشعارات",
              style: TextStyle(
                fontSize: width * 0.055,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.06, vertical: height * 0.01),
            width: width,
            child: Text(
              "اليوم",
              style: TextStyle(
                fontSize: width * 0.05,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            height: height * 0.37,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: state.length,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.all(width * 0.015),
                  padding: EdgeInsets.all(width * 0.015),
                  height: height * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("${state[i]}",
                      style: TextStyle(fontSize: width * 0.045)),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.06, vertical: height * 0.02),
            width: width,
            child: Text(
              "اليوم السابق",
              style: TextStyle(
                fontSize: width * 0.05,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            height: height * 0.3,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, i) {
                return Container(
                  margin: EdgeInsets.all(width * 0.015),
                  padding: EdgeInsets.all(width * 0.015),
                  height: height * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("تم تسجبل غياب الطالب",
                      style: TextStyle(fontSize: width * 0.045)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List state = [
  "الباص علئ وشك الوصول",
  "تم صعود الطالب للباص",
  "تم صعود الطالب للباص",
  "تم صعود الطالب للباص",
  "تم نزول الطالب من الباص"
];
