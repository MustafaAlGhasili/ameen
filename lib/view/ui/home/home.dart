import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../controller/home_controller.dart';
import 'home_widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController();

    controller.bottomIndex.value =1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => homePages.elementAt(controller.bottomIndex.value)),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        child: Obx(
          () => Theme(
            data: ThemeData(
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                elevation: 5,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.white60,
                backgroundColor: Color.fromARGB(255, 113, 65, 146),
                selectedItemColor: Colors.white,
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.bottomIndex.value,
              onTap: (value) {
                // controller.bottomIndex.value = value;
              },
              items: const [
                BottomNavigationBarItem(
                  tooltip: "Home",
                  icon: Icon(IconlyLight.home),
                  label: "Home",
                  activeIcon: Icon(IconlyBold.home),
                ),
                BottomNavigationBarItem(
                  tooltip: "Profile",
                  icon: Icon(IconlyLight.profile),
                  activeIcon: Icon(IconlyBold.profile),
                  label: "Profile",
                ),
                BottomNavigationBarItem(
                  tooltip: "Notification",
                  icon: Icon(IconlyLight.notification),
                  activeIcon: Icon(IconlyBold.notification),
                  label: "Notification",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> homePages = [
  const HomePage(),
  const ProfilePage(),
  const NotificationPage()
];
