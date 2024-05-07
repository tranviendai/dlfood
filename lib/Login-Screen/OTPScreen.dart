// ignore_for_file: file_names
import 'package:flutter/material.dart';


class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification', style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/main_logo.jpg',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Xử lý khi nhấn nút Enter
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}