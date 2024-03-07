import 'package:ameen/controller/sign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldModel extends StatefulWidget {
  final String? hint;
  final String? label;
  final Widget? sufIcon;
  final double vPadding;
  final double hPadding;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? text;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final bool? isEnabled;

  // final String? Function(String?)? validator;

  const TextFieldModel({
    super.key,
    this.hint,
    this.label,
    this.sufIcon,
    this.vPadding = 0.0,
    this.hPadding = 0.0,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.text,
    this.keyboardType,
    this.style,
    this.isEnabled = true,
    // this.validator,
  });

  @override
  State<TextFieldModel> createState() => _TextFieldModelState();
}

class _TextFieldModelState extends State<TextFieldModel> {
  SignController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return
        //  Column(
        // children: [
        // widget.text == null
        //     ? const Text("")
        //     : Container(
        //         padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        //         width: w,
        //         child: Text(
        //           "${widget.text}",
        //           textAlign: TextAlign.start,
        //           style: TextStyle(fontSize: w * 0.05, height: 1.5),
        //         ),
        //       ),
        Padding(
      padding: EdgeInsets.only(top: widget.vPadding, left: widget.hPadding),
      child: TextFormField(
        enableInteractiveSelection: widget.isEnabled,
        enabled: widget.isEnabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: widget.keyboardType,
        cursorRadius: const Radius.circular(10),
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty || value == 'null') {
            return '*required';
          }
          return null;
        },
        style: widget.style,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            label: Text("${widget.text}"),
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            hintText: widget.hint,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 113, 65, 146),
              ),
            ),
            suffixIcon: widget.sufIcon,
            labelStyle: const TextStyle(color: Colors.black),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 113, 65, 146),
              ),
            )),
        // ),
        // ],
      ),
    );
  }
}
