import 'package:Amin/controller/sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/home_controller.dart';
import 'home_pages/home_page.dart';
import 'home_pages/parent_notification.dart';
import 'home_pages/profile_page.dart';

class Home extends StatelessWidget {
  final int index;

  const Home({super.key, this.index = 0});

  @override
  Widget build(BuildContext context) {

    Get.put(SignController());

    Get.put(HomeController());
    HomeController controller = Get.find();
    controller.bottomIndex.value = index;
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
                type: BottomNavigationBarType.shifting,
                unselectedItemColor: Colors.white60,
                backgroundColor: Color.fromARGB(255, 113, 65, 146),
                selectedItemColor: Colors.white,
              ),
            ),
            child: BottomNavigationBar(
              unselectedItemColor: Colors.white38,
              selectedItemColor: Colors.white70,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.bottomIndex.value,
              onTap: (value) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                print(prefs.getString('parent'));
                controller.bottomIndex.value = value;
              },
              items: const [
                BottomNavigationBarItem(
                  tooltip: "Home",
                  icon: Icon(IconlyLight.home),
                  label: "Home",
                  activeIcon: Icon(IconlyBold.home),
                ),
                BottomNavigationBarItem(
                  tooltip: "Notification",
                  icon: Icon(IconlyLight.notification),
                  activeIcon: Icon(IconlyBold.notification),
                  label: "Notification",
                ),
                BottomNavigationBarItem(
                  tooltip: "Profile",
                  icon: Icon(IconlyLight.profile),
                  activeIcon: Icon(IconlyBold.profile),
                  label: "Profile",
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
  const ParentNotificationsPage(),
  const ProfilePage(),
];
