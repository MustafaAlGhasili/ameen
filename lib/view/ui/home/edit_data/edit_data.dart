import 'package:Amin/model/parent.dart';
import 'package:Amin/model/student.dart';
import 'package:Amin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'edit_parent.dart';
import 'edit_student.dart';


class EditPage extends StatelessWidget {
  final int no;
  final StudentModel? student;
  final ParentModel? parent;

  const EditPage({super.key, required this.no, this.parent, this.student});

  @override
  Widget build(BuildContext context) {
    String name = no == 0 ? "الطالب" : "ولي الامر";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text("تعديل بيانات $name"),
          ),
          backgroundColor: Colors.white,
          body: no == 0
              ? EditStudent(student: student!)
              : EditParent(parent: parent!)),
    );
  }
}
