import 'package:ameen/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/custom_divider.dart';
import '../../widget/custom_state.dart';


class StatePage extends StatelessWidget {
  const StatePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();



    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Obx(() => Column(
      children: [
        SizedBox(
          height: height * 0.05,
        ),
         CustomState(
          state: controller.isInTheWay.value,
          childText: "1",
          text: "في الطريق",
        ),
        CustomDivider(
          height: height * 0.05,
          rightMargin: width * 0.132,
        ),
        CustomState(
          state: controller.isClose.value,
          childText: "2",
          text: "على وشك الوصول",
        ),
        CustomDivider(
          height: height * 0.05,
          rightMargin: width * 0.132,
        ),
         CustomState(
          state: controller.isArrived.value,
          childText: "3",
          text: "وصلت الحافلة",
        ),
      ],
    ));
  }
}
