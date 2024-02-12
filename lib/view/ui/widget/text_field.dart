import 'package:ameen/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldModel extends StatefulWidget {
  final String? hint;
  final String? label;
  final Widget? sufIcon;
  final double? height;
  final double? width;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? text;

  // final String? Function(String?)? validator;

  const TextFieldModel({
    super.key,
    this.hint,
    this.label,
    this.sufIcon,
    this.height,
    this.width,
    required this.obscureText,
    this.controller,
    this.onChanged,
    this.text,
    // this.validator,
  });

  @override
  State<TextFieldModel> createState() => _TextFieldModelState();
}

class _TextFieldModelState extends State<TextFieldModel> {
  SignController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.015),
      child: Column(
        children: [
          widget.text == null
              ? const Text("")
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  width: width,
                  child: Text(
                    "${widget.text}",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: width * 0.05),
                  ),
                ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                )),
            height: widget.height,
            width: widget.width,
            child: TextFormField(
              style: const TextStyle(
                height: 1,
              ),
              controller: widget.controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length < 3) {
                  return "slkmslkv";
                }
                return null;
              },
              onChanged: widget.onChanged,
              obscureText: widget.obscureText,
              decoration: InputDecoration(
                  // prefixIcon: ,
                  hintText: widget.hint,
                  labelText: widget.label,
                  suffixIcon: widget.sufIcon,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 113, 65, 146),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
