import 'package:ameen/model/notification.dart';
import 'package:ameen/utils/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  String _formatDate(String isoDate) {
    DateTime parsedDate = DateTime.parse(isoDate);
    initializeDateFormatting('ar_SA', null);
    return DateFormat('d MMMM hh:mm a', 'ar_SA')
        .format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ar'); // 'ar' for Arabic locale

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.notifications,
                color: Color.fromARGB(255, 113, 65, 146), size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDate(notification.createdAt!), // Format the date
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification.title!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () {
                // Show the confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('تأكيد الحذف'),
                      content: const Text('هل أنت متأكد أنك تريد حذف هذا الإشعار؟'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('إلغاء'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final databaseHelper = DatabaseHelper();
                            await databaseHelper.deleteById(
                                notification.id, "notifications");
                            // Perform the delete operation here
                            // Then close the dialog
                            Navigator.of(context).pop();
                          },
                          child: const Text('حذف'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
