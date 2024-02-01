import 'package:flutter/material.dart';

class TextFieldModel extends StatelessWidget {
  String? hint;
  String? label;
  Widget? sufIcon;
  double? height;
  double? width;

  TextFieldModel(
      {super.key,
      this.hint,
      this.label,
      this.sufIcon,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(13),
            )),
        height: height,
        width: width,
        child: TextFormField(
          decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              suffixIcon: sufIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 113, 65, 146),
                ),
              )),
        ),
      ),
    );
  }
}
