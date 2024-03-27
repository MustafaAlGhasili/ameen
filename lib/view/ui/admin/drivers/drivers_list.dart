import 'package:ameen/model/driver.dart';
import 'package:ameen/view/ui/admin/drivers/add_driver.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../utils/DatabaseHelper.dart';
import '../../widget/button_model.dart';
import 'driver_info.dart';

class DriversList extends StatefulWidget {
  const DriversList({super.key});

  @override
  _DriversListState createState() => _DriversListState();
}

class _DriversListState extends State<DriversList> {
  bool _isSearching = false;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 113, 65, 146),
          foregroundColor: Colors.white,
          centerTitle: true,
          title: _isSearching
              ? TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'ابحث...',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              // Implement search logic here
              setState(() {});
            },
          )
              : const Text(
            "قائمة السائقين",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                  }
                });
              },
              icon: Icon(
                _isSearching ? Icons.close : IconlyLight.search,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.75,
                padding: EdgeInsets.only(top: height * 0.05),
                child: FirebaseAnimatedList(
                  query: DatabaseHelper.driverRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    DriverModel driver = DriverModel.fromSnapshot(snapshot);
                    if (snapshot.children.isEmpty) {
                      return const Center(
                        child: Text("No data found"),
                      );
                    }

                    // Apply search filter
                    if (_searchController.text.isNotEmpty &&
                        !driverMatchesSearch(driver, _searchController.text)) {
                      return const SizedBox(); // Hide item if it doesn't match the search
                    }

                    return ButtonModel(
                      onTap: () {
                        Get.to(() => DriverInfo(driver: driver));
                      },
                      bus: true,
                      imgUrl: "img/st1.png",
                      padding: 10,
                      hMargin: width * 0.05,
                      vMargin: height * 0.02,
                      height: height * 0.08,
                      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                      backColor: const Color.fromARGB(255, 113, 65, 146),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.05,
                      ),
                      content: '${driver.fName} ${driver.lName}',
                    );
                  },
                  defaultChild:
                  const Center(child: CircularProgressIndicator()),
                ),
              ),
              ButtonModel(
                onTap: () {
                  Get.to(() => const AddDriver());
                },
                padding: 10,
                hMargin: width * 0.05,
                vMargin: height * 0.02,
                height: height * 0.06,
                rowMainAxisAlignment: MainAxisAlignment.center,
                backColor: const Color.fromARGB(255, 113, 65, 146),
                style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                content: "اضافة سائق جديد",
              ),
            ],
          ),
        ),
      ),
    );
  }


  bool driverMatchesSearch(DriverModel driver, String searchText) {
    return driver.fName.contains(searchText) ||
        driver.lName.contains(searchText);
  }
}
/*

List<Map<String, String>> drivers = [
  {"name": "احمد سعيد", "img": "img/img.png", "busName": "B1"},
  {"name": "سعد عبدالله", "img": "img/img2.png", "busName": "C1"},
];
*/
