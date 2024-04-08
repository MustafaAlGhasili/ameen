import 'package:ameen/view/ui/sign/sign_in/sign_in.dart';
import 'package:flutter/material.dart';

class WaitingApprovalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer, // You can change the icon as needed
              size: 100, // Adjust the size of the icon as needed
              color: Colors.white, // Adjust the color of the icon as needed
            ),
            SizedBox(height: 20),
            Text(
              'يرجى الانتظار حتى يوافق المشرف على تسجيلك',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()), // Navigate to the sign-in screen
                );
              },
              child: Text(
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

