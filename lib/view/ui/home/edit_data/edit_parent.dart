import 'package:Amin/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../../model/parent.dart';
import '../../../../services/LocalStorageService.dart';
import '../../../../utils/DatabaseHelper.dart';
import '../../../../utils/constants.dart';
import '../../widget/button_model.dart';
import '../../widget/text_field.dart';
import '../home.dart';

class EditParent extends StatelessWidget {
  final ParentModel parent;

  const EditParent({super.key, required this.parent});

  @override
  Widget build(BuildContext context) {
    Validation validation = Validation();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    TextEditingController fName = TextEditingController();
    TextEditingController lName = TextEditingController();
    TextEditingController nationalId = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();

    fName.text = parent.fName;
    lName.text = parent.lName;
    nationalId.text = parent.nationalId;
    phone.text = parent.phone;
    email.text = parent.email;

    DatabaseHelper dbHelper = DatabaseHelper();
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.07,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.fName = val;
              },
              hPadding: width * 0.04,
              validator: (val) => validation.validator(val),
              controller: fName,
              keyboardType: TextInputType.name,
              text: "الاسم الاول",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.lName = val;
              },
              hPadding: width * 0.04,
              validator: (val) => validation.validator(val),
              controller: lName,
              keyboardType: TextInputType.name,
              text: "الاسم الأخير",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.nationalId = val;
              },
              hPadding: width * 0.04,
              validator: (val) => validation.validator(val),
              controller: nationalId,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              text: "رقم الاحوال",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.phone = val;
              },
              hPadding: width * 0.04,

              validator: (val) => validation.phoneValidator(val),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 10,
              controller: phone,
              // vPadding: height * 0.035,
              keyboardType: TextInputType.number,
              text: "رقم التواصل",
            ),
            SizedBox(
              height: height * 0.035,
            ),
            TextFieldModel(
              onChanged: (val) {
                parent.email = val;
              },
              hPadding: width * 0.04,

              validator: (val) => validation.emailValidator(val),
              controller: email,
              // vPadding: height * 0.035,
              keyboardType: TextInputType.emailAddress,
              text: "الإيميل",
            ),
            SizedBox(
              height: height * 0.05,
            ),
            ButtonModel(
              content: 'حفظ',
              height: height * 0.05,
              width: width * 0.9,
              rowMainAxisAlignment: MainAxisAlignment.center,
              backColor: PRIMARY_COLOR,
              style: TextStyle(color: Colors.white, fontSize: width * 0.05),
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  Get.dialog(
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );

                  await LocalStorageService.saveParent(parent);

                  await dbHelper.update(parent, 'parents');

                  Get.off(() => const Home(
                        index: 2,
                      ));
                  Get.showSnackbar(
                    GetSnackBar(
                      borderRadius: 20,
                      margin: EdgeInsets.symmetric(
                          horizontal: width * 0.045, vertical: height * 0.015),
                      icon: Icon(
                        IconlyLight.info_circle,
                        color: Colors.white,
                        size: width * 0.065,
                      ),
                      message: "تم تحديث البيانات بنجاح",
                      duration: const Duration(seconds: 2),
                      animationDuration: const Duration(milliseconds: 800),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
