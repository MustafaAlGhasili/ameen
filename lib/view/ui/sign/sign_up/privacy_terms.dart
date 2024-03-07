import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/home.dart';
import 'sign_up.dart';

class PrivacyTerms extends StatelessWidget {
  const PrivacyTerms({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          children: [
            Text("الشروط والأحكام", style: TextStyle(fontSize: width * 0.07)),
            SizedBox(
              height: width * 0.02,
            ),
            Text(
                style: TextStyle(fontSize: width * 0.04),
                "مرحبًا بك في تطبيق أمين "
                "يرجى قراءة هذه الشروط والأحكام بعناية قبل استخدام التطبيق. بمجرد استخدامك للتطبيق، فإنك توافق على هذه الشروط والأحكام بشكل كامل وملزم.\n"
                "1. ملكية المحتوى: "
                "المحتوى الذي يتم مشاركته أو نشره عبر تطبيق أمين هو ملكية التطبيق والمستخدمين والجهات الخارجية. لا يجوز نسخ أو نشر المحتوى دون إذن كتابي.\n"
                "2. تراخيص الاستخدام: "
                "يجب استخدام تطبيق أمين بأمان وبالامتثال لجميع القوانين واللوائح المحلية والدولية. يجب عدم استخدام التطبيق بأي طريقة تنتهك حقوق الملكية الفكرية أو تعرض سلامة المستخدمين للخطر.\n"
                "3. الخصوصية وحماية البيانات: "
                "نحن نلتزم بحماية خصوصية المستخدمين. سيتم جمع واستخدام البيانات الشخصية وفقًا لسياسة الخصوصية المتاحة في التطبيق.\n"
                "4. التعويض والضمان: "
                "يجب على المستخدمين فهم أن التطبيق يقدم كما هو ودون أي ضمانات صريحة أو ضمانات من أي نوع.\n"
                "5. إنهاء الخدمة: "
                "يمكن أن تؤدي انتهاكات الشروط والأحكام إلى إنهاء حظر المستخدمين. نحتفظ بالحق في إنهاء الخدمة في أي وقت.\n"
                "6. تحديث الشروط والأحكام: "
                "يمكن أن تتغير هذه الشروط والأحكام مع مرور الوقت. سيتم إشعار المستخدمين بأي تغييرات."),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.02, horizontal: width * 0.01),
                child: GestureDetector(
                  onTap: () {
                    controller.isAccepted.value = !controller.isAccepted.value;
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: controller.isAccepted.value,
                        onChanged: (val) {
                          controller.isAccepted.value =
                              !controller.isAccepted.value;
                        },
                      ),
                      Text(
                        "أوافق على الشروط والأحكام",
                        style: TextStyle(fontSize: width * 0.045),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isAccepted.value
                    ? () async {
                        final result = await controller.registerParent();

                        print("result is $result");
                        if (result) {
                          Get.offAll(() => const Home());
                        }
                      }
                    : null,
                // Set onPressed to null if checkbox is not checked
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 113, 65, 146),
                  minimumSize: Size(width * 0.9, height * 0.055),
                ),
                child: Visibility(
                  visible: !controller.isLoading.value,
                  replacement: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  child: Text(
                    'التالي',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.05,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
