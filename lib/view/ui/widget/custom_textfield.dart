// import 'package:flutter/material.dart';
//
// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final TextInputType? keyboardType;
//   final bool? isObscureText;
//   final String? obscureChar;
//   final String hint;
//   final Widget? preIcon;
//   final Widget? sufIcon;
//
//   const CustomTextField(
//       {super.key,
//       required this.controller,
//       this.keyboardType,
//       this.isObscureText = false,
//       this.obscureChar = '*',
//       required this.hint,
//       this.preIcon,
//       this.sufIcon});
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return TextFormField(
//       controller: controller,
//       obscureText: isObscureText!,
//       obscuringCharacter: obscureChar!,
//       keyboardType: keyboardType!,
//       style: TextStyle(),
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.only(top: 12.0),
//         filled: true,
//         fillColor: Colors.white30,
//         constraints: BoxConstraints(maxHeight: height * 0.065, maxWidth: width),
//         hintText: hint,
//         // hintStyle: ,
//         prefixIcon: preIcon,
//         suffixIcon: sufIcon,
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: const BorderSide(
//               color: Colors.grey,
//               width: 1.0,
//             )),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: const BorderSide(
//               color: Colors.white12,
//               width: 1.0,
//             )),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: const BorderSide(
//               color: Colors.white12,
//               width: 1.0,
//             )),
//       ),
//     );
//   }
// }
