import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../../model/student.dart';
import '../../../utils/DatabaseHelper.dart';
import '../map/navigate_map.dart';

class Trip extends StatelessWidget {
  final int tripType;
  const Trip({Key? key, required this.tripType}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String title = tripType == 2 ? "رحلة المساء" : "رحلة الصباح"; // Set the title based on tripType

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawer(),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: PRIMARY_COLOR,
          title: Text(title,
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.06,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(width * 0.03),
                decoration: UnderlineTabIndicator(
                    insets: EdgeInsets.only(left: width * 0.4),
                    borderSide:
                        const BorderSide(color: Colors.black38, width: 1.5)),
                width: width,
                child: Text(
                  'قائمة الطلاب في الباص',
                  style: TextStyle(
                    fontSize: width * 0.06,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.45,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: names.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.015),
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)),
                      height: height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: width * 0.07,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(imgs[i]),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                names[i],
                                style: TextStyle(fontSize: width * 0.045),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                dis[i],
                                style: TextStyle(fontSize: width * 0.045),
                              ),
                              ButtonModel(
                                rowMainAxisAlignment: MainAxisAlignment.center,
                                hMargin: width * 0.03,
                                height: height * 0.03,
                                width: width * 0.15,
                                content: 'بدء',
                                backColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(width * 0.03),
                decoration: UnderlineTabIndicator(
                    insets: EdgeInsets.only(left: width * 0.4),
                    borderSide:
                        const BorderSide(color: Colors.black38, width: 1.5)),
                width: width,
                child: Text(
                  'قائمة انتظار الطلاب',
                  style: TextStyle(
                    fontSize: width * 0.06,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.45,
                child: FirebaseAnimatedList(
                  query: DatabaseHelper.studentsRef
                      .orderByChild('busId')
                      .equalTo("B1"),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    StudentModel student = StudentModel.fromSnapshot(snapshot);

                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.015),
                      decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(10)),
                      height: height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: CachedNetworkImage(
                                    imageUrl: student.imgUrl!,
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Image(image: AssetImage("img/st1.png")),
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
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                "${student.fName} ${student.lName}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.045),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                               "2KM",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.045),
                              ),
                              ButtonModel(
                                onTap:(){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => NavigationScreen(
                                          student.latitude!,student.longitude!,
                                          studentName:  "${student.fName} ${student.lName}",
                                          addressDescription: student.address
                                      )));
                                },
                                rowMainAxisAlignment: MainAxisAlignment.center,
                                hMargin: width * 0.03,
                                height: height * 0.03,
                                width: width * 0.15,
                                content: 'بدء',
                                backColor: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                    },
                  defaultChild:
                  const Center(child: CircularProgressIndicator()),
                ),


              ),
            ],
          ),
        ),
      ),
    );
  }
}

List dis = ['1km', '2km', '3km', '4km'];
List imgs = ['img/img.png', 'img/img2.png', 'img/st1.png', 'img/st2.png'];
List names = ['احمد خالد', 'سارة عبدالعزيز', 'ود احمد', 'هند محمد'];
