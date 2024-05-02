import 'package:flutter/material.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('img/offline.png')
        ],
      ),
    );
  }
}
