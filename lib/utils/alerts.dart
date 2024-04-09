
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

void showSuccessAlert() {
  QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.success,
      animType: QuickAlertAnimType.slideInUp,
      text: 'Do you want to logout',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      headerBackgroundColor: Colors.black
  );

}

void showDeleteConfirmationDialog( String itemName) async {

  QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.warning,
      title: "Confirm",
      text: "Are you sure you want to delete this item?",
      confirmBtnText: "Yes",
      cancelBtnText: "No",
      onConfirmBtnTap: () {
        // Handle confirmation action (e.g., delete item)
        print("Confirmed deletion!");
      }
  );

}
