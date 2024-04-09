import 'package:ameen/model/notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ParentNotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const ParentNotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  String _formatDate(String isoDate) {
    DateTime parsedDate = DateTime.parse(isoDate);
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (parsedDate.year == now.year &&
        parsedDate.month == now.month &&
        parsedDate.day == now.day) {
      final formattedTime = DateFormat('hh:mm a', 'ar').format(parsedDate);
      return 'اليوم $formattedTime';
    } else if (parsedDate.year == yesterday.year &&
        parsedDate.month == yesterday.month &&
        parsedDate.day == yesterday.day) {
      final formattedTime = DateFormat('hh:mm a', 'ar').format(parsedDate);
      return 'أمس $formattedTime';
    } else {
      final DateFormat formatter = DateFormat('d MMMM yyyy hh:mm a', 'ar');
      return formatter.format(parsedDate);
    }
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
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.notifications,
                color: Color.fromARGB(255, 113, 65, 146), size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDate(notification.createdAt!), // Format the date
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    notification.title!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
