import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import 'button_model.dart';

class CustomDialog extends StatelessWidget {
  final void Function()? buttonOnTap;
  final String buttonText;
  final String content;
  final void Function()? onClose; // Callback for closing the dialog

  const CustomDialog({
    super.key,
    this.buttonOnTap,
    required this.buttonText,
    required this.content,
    this.onClose, // Added callback parameter
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(width * 0.02),
        height: height * 0.2,

        alignment: Alignment.center,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child:  Icon(Icons.close, size: width * 0.065,),
                onTap: () {
                 navigator!.pop();
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.033,
              ),
              ButtonModel(

                onTap: buttonOnTap,
                height: height * 0.05,
                hMargin: width * 0.02,
                style: TextStyle(color: Colors.white, fontSize: width * 0.04),
                rowMainAxisAlignment: MainAxisAlignment.center,
                content: buttonText,
                backColor: PRIMARY_COLOR,
              )
            ],
          ),
        ),
      ),
    );
  }
}
