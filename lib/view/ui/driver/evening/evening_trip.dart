import 'package:ameen/utils/constants.dart';
import 'package:ameen/view/ui/widget/button_model.dart';
import 'package:flutter/material.dart';

class ETrip extends StatelessWidget {
  const ETrip({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: const Drawer(),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: PRIMARY_COLOR,
          title: Text("رحلة المساء",
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
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: names.length,
                  itemBuilder: (context, i) {
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.045),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                dis[i],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.045),
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