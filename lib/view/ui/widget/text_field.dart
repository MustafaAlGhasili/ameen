import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldModel extends StatefulWidget {
  final String? hint;
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
  final bool readOnly;
  final int? maxLength;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final int maxLines;

  // final String? Function(String?)? validator;

  const TextFieldModel({
    super.key,
    this.hint,
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
    this.readOnly = false,
    this.maxLength,
    this.validator,
    this.inputFormatters,
    this.onTap,
    this.maxLines = 1,
    // this.validator,
  });

  @override
  State<TextFieldModel> createState() => _TextFieldModelState();
}

class _TextFieldModelState extends State<TextFieldModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.vPadding, left: widget.hPadding, right: widget.hPadding),
      child: TextFormField(
        maxLines: widget.maxLines,
        onTap: widget.onTap,
        maxLength: widget.maxLength,
        inputFormatters: widget.inputFormatters,
        readOnly: widget.readOnly,
        enableInteractiveSelection: widget.isEnabled,
        enabled: widget.isEnabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: widget.keyboardType,
        cursorRadius: const Radius.circular(10),
        controller: widget.controller,
        validator: widget.validator,

        style: widget.style,
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            label: Text("${widget.text}"),
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(25, 27, 25, 0),
            hintText: widget.hint,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(color: Colors.red.shade300),
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
