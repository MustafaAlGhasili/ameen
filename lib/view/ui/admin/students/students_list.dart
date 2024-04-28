import 'package:ameen/view/ui/admin/students/student_info.dart';
import 'package:ameen/view/ui/admin/students/waiting_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../../model/student.dart';
import '../../../../utils/DatabaseHelper.dart';
import '../../widget/button_model.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
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

    DatabaseHelper dbHelper = DatabaseHelper();
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
                  decoration: const InputDecoration(
                    hintText: 'ابحث...',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    // Implement search logic here
                    setState(() {});
                  },
                )
              : const Text(
                  "قائمة الطلاب",
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
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: FutureBuilder(
                    future: dbHelper.getStudentsParentsByStatus(true),
                    builder: (context, snapshot) {
                      final student = snapshot.data;

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, i) {
                            if (_searchController.text.isNotEmpty &&
                                !studentMatchesSearch(
                                    student![i], _searchController.text)) {
                              return const SizedBox(); // Hide item if it doesn't match the search
                            }
                            return ButtonModel(
                              onTap: () {
                                Get.to(() => StudentDetails(
                                      student: student[i],
                                      no: 0,
                                    ));
                              },
                              bus: true,
                              imgUrl: student![i].imgUrl!,
                              padding: 7,
                              hMargin: width * 0.05,
                              vMargin: height * 0.02,
                              height: height * 0.083,
                              rowMainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              backColor:
                                  const Color.fromARGB(255, 113, 65, 146),
                              style: TextStyle(
                                  color: Colors.white, fontSize: width * 0.05),
                              content:
                                  '${student[i].fName} ${student[i].lName}',
                            );
                          },
                        );
                      }
                      return const Center(
                        child: Text("No data found"),
                      );
                    },
                  )),
              ButtonModel(
                  onTap: () {
                    Get.to(() => const WaitingList());
                  },
                  hMargin: width * 0.05,
                  vMargin: height * 0.02,
                  height: height * 0.07,
                  rowMainAxisAlignment: MainAxisAlignment.center,
                  backColor: const Color.fromARGB(255, 113, 65, 146),
                  style: TextStyle(color: Colors.white, fontSize: width * 0.05),
                  content: "قائمة الانتظار"),
            ],
          ),
        ),
      ),
    );
  }

  bool studentMatchesSearch(StudentModel student, String searchText) {
    return student.fName.contains(searchText) ||
        student.lName.contains(searchText);
  }
}
