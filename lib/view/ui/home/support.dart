import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:iconly/iconly.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("الدعم",
              style: TextStyle(
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 114, 64, 164),
        ),
        body: const Column(
          children: [
            Faq(
              question: "الأسئلة الأكثر شيوعا",
              answer:
                  "كيف يمكنني تحميل التطبيق؟ توضح هذه السؤال الخطوات الأساسية لتنزيل وتثبيت التطبيق من متجر التطبيقات المعني (Google Play Store للأندرويد، مثلًا).",
            ),
            Faq(
              question: "عن أمين",
              answer:
                  "أمين هو تطبيق يعتمد على تقنية الذكاء الاصطناعي للتعرف على وجوه الطلاب وضمان سلامتهم أثناء ركوبهم وخروجهم من الحافلة المدرسية، لمنع حالات الاختناق. و يستخدم أمين نظام تتبع على الخريطة لمراقبة مسار الحافلة المدرسية التي يستقلها الطلاب، مما يوفر لأولياء الأمور الراحة والطمأنينة أثناء رحلة أبنائهم إلى المدرسة.",
            ),
            Faq(
              question: "الشكاوى و المقترحات",
              answer:
                  "تواصل عبر الايميل amin@gmail.com \nالرقم الموحد 05xxxxxxxxx",
            ),
            Faq(
              question: "دليل المستخدم",
              answer:
              "دليل المستخدم",
            ),
          ],
        ),
      ),
    );
  }
}

class Faq extends StatelessWidget {
  final String question;
  final String answer;

  const Faq({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return FAQ(
      collapsedIcon: Icon(Icons.add, size: width * 0.07),
      expandedIcon: Icon(Icons.remove, size: width * 0.07),
      ansDecoration: const BoxDecoration(
        color: Colors.black12,
      ),
      question: question,
      answer: answer,
      queDecoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black)),
      ),
      ansStyle:  TextStyle(color: Colors.black, fontSize: width * 0.043),
      queStyle: TextStyle(color: Colors.black, fontSize: width * 0.055),
      separator: const SizedBox(
        height: 15,
      ),
    );
  }
}
