import 'package:ameen/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendNotification extends StatelessWidget {
  const SendNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARY_COLOR,
            foregroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              CupertinoTextFormFieldRow(
                decoration: BoxDecoration(color: Colors.red),
              ),
            ],
          ),
        ));
  }
}
