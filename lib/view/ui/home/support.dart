import 'package:Amin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';

const String userGuied = "تصميم واجهة التطبيق أمين شريك طفلك بالرحلة المدرسية"
    "تم تصميم واجهة التطبيق أمين شريك طفلك بالرحلة المدرسية لتلبية احتياجات الأهل والسائقين والمشرفين. ستجد هنا وصفًا مفصلاً للواجهات المختلفة في التطبيق ووظائفها."
    "واجهة الترحيب:"
    "تحتوي على شعار أمين وتوضح أن التطبيق هو شريك طفلك بالرحلة المدرسية"
    "واجهة الاختيار:"
    "تتيح للمستخدم اختيار بين الأهل والسائقين والمشرفين ."
    "واجهة تسجيل الدخول للأهل:"
    'تسمح للأهل بإنشاء حساب جديد أو تسجيل الدخول باستخدام البريد الإلكتروني وكلمة المرور .'
    "استعادة كلمة المرور:"
    'يمكن للأهل استعادة كلمة المرور عن طريق إدخال عنوان البريد الإلكتروني واتباع الخطوات المطلوبة.'
    'التسجيل:'
    'يمكن للأهل إنشاء حساب جديد عن طريق إدخال المعلومات الشخصية ومعلومات الطالب واختيار المدرسة وتحميل صورة وجه الطالب والموافقة على الشروط والأحكام'
    "صفحة الأهل:"
    "تعرض معلومات الطالب والخيارات المتاحة للأهل مثل عرض معلومات الحافلة وتتبع الموقع على الخريطة والحالة ."
    "صفحة الخريطة:"
    "تعرض موقع الحافلة ومسار الرحلة من المنزل إلى المدرسة والعودة ."
    'صفحة الحالة:'
    "يمكن للأهل التحقق من حالة استلام الطالب بشريط يعرض أهداف الرحلة ."
    "صفحة الإشعارات:"
    'تعرض الأحداث الهامة وجميع المعلومات التي يتلقاها الأهل .'
    "صفحة ملف الأهل:"
    "يمكن للأهل عرض صورة واسم الطالب والوصول إلى خيارات مثل حسابي وإبلاغ الغياب والإعدادات وتسجيل الخروج."
    "صفحة حسابي:"
    "يمكن للأهل عرض جميع معلوماتهم ومعلومات الطالب."
    "واجهة تسجيل الدخول للمشرف والسائق:"
    "افتح التطبيق وأدخل رقم المعرف الخاص بك وكلمة المرور."
    "انقر على زر تسجيل الدخول للوصول إلى الحساب المناسب."
    'صفحة البداية للسائق:'
    "بعد تسجيل الدخول كسائق، ستظهر لك صفحة البداية للسائق."
    "هنا، لديك ثلاثة خيارات: بدء وردية العمل، عرض المزيد من الخيارات، أو تسجيل الخروج."
    "القائمة:"
    "انقر فوق أيقونة القائمة للوصول إلى خدمات التطبيق الإضافية للسائقين."
    "من القائمة، يمكنك تحديد الخيارات مثل معلوماتي لعرض تفاصيلك الشخصية، وقائمة الطلاب لعرض قائمة الطلاب الموكلين إلى حافلتك، وحالة الطوارئ للحالات الطارئة."
    "قوائم اليوم:"
    'انقر على "بدء العمل" لعرض قائمة الطلاب الذين يجب عليك نقلهم.'
    "بالنسبة لكل طالب، انقر على بدء لبدء الرحلة."
    "بمجرد الانتهاء من جميع عمليات نقل الطلاب، ستظهر خيار إنهاء العمل."
    "صفحة انتهاء الرحلة:"
    " بعد الانتهاء من جميع رحلات النقل، ستظهر لك صفحة انتهاء الرحلة."
    "يمكنك هنا تأكيد ما إذا تم نقل جميع الطلاب في القائمة أم لا."
    "       صفحة الخريطة:"
    "        عند النقر على الخريطة، ستظهر لك الخريطة العادية للسائق."
    "     يمكنك رؤية وجهة الطالب، موقعك الحالي ومعلومات أخرى حول موقع الطالب.";

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: Colors.white,
            title: const Text("الدعم",
                style: TextStyle(
                  color: Colors.white,
                )),
            centerTitle: true,
            backgroundColor: PRIMARY_COLOR,
          ),
          body: SizedBox(
            height: height,
            child: ListView.builder(
              itemCount: question.length,
              itemBuilder: (context, i) {
                return Faq(question: question[i], answer: answer[i]);
              },
            ),
          )),
    );
  }
}

// Column(
// children: [
// Faq(
// question: "الأسئلة الأكثر شيوعا",
// answer:
// "كيف يمكنني تحميل التطبيق؟ توضح هذه السؤال الخطوات الأساسية لتنزيل وتثبيت التطبيق من متجر التطبيقات المعني (Google Play Store للأندرويد، مثلًا).",
// ),
// Faq(
// question: "عن أمين",
// answer:
// "أمين هو تطبيق يعتمد على تقنية الذكاء الاصطناعي للتعرف على وجوه الطلاب وضمان سلامتهم أثناء ركوبهم وخروجهم من الحافلة المدرسية، لمنع حالات الاختناق. و يستخدم أمين نظام تتبع على الخريطة لمراقبة مسار الحافلة المدرسية التي يستقلها الطلاب، مما يوفر لأولياء الأمور الراحة والطمأنينة أثناء رحلة أبنائهم إلى المدرسة.",
// ),
// Faq(
// question: "الشكاوى و المقترحات",
// answer:
// "تواصل عبر الايميل amin@gmail.com \nالرقم الموحد 05xxxxxxxxx",
// ),
// SizedBox(
// height: height * 0.6,
// child: SingleChildScrollView(
// child: Faq(question: "دليل المستخدم", answer: userGuied),
// ),
// ),
// ],
// ),
List question = [
  "الأسئلة الأكثر شيوعا",
  "عن أمين",
  "الشكاوى و المقترحات",
  "دليل المستخدم"
];

List answer = [
  "كيف يمكنني تحميل التطبيق؟ توضح هذه السؤال الخطوات الأساسية لتنزيل وتثبيت التطبيق من متجر التطبيقات المعني (Google Play Store للأندرويد، مثلًا).",
  "أمين هو تطبيق يعتمد على تقنية الذكاء الاصطناعي للتعرف على وجوه الطلاب وضمان سلامتهم أثناء ركوبهم وخروجهم من الحافلة المدرسية، لمنع حالات الاختناق. و يستخدم أمين نظام تتبع على الخريطة لمراقبة مسار الحافلة المدرسية التي يستقلها الطلاب، مما يوفر لأولياء الأمور الراحة والطمأنينة أثناء رحلة أبنائهم إلى المدرسة.",
      "تواصل عبر الايميل amin@gmail.com \nالرقم الموحد 05xxxxxxxxx",
  userGuied,
];

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
      ansStyle: TextStyle(color: Colors.black, fontSize: width * 0.043),
      queStyle: TextStyle(color: Colors.black, fontSize: width * 0.055),
      separator: const SizedBox(
        height: 15,
      ),
    );
  }
}
