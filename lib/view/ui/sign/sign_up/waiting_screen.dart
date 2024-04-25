import 'package:ameen/view/ui/sign/start.dart';
import 'package:flutter/material.dart';

class WaitingApprovalScreen extends StatelessWidget {
  const WaitingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.timer, // You can change the icon as needed
              size: 100, // Adjust the size of the icon as needed
              color: Colors.white, // Adjust the color of the icon as needed
            ),
            const SizedBox(height: 20),
            const Text(
              'يرجى الانتظار حتى يوافق المشرف على تسجيلك',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Start()), // Navigate to the sign-in screen
                );
              },
              child: const Text(
                'حسناً',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

