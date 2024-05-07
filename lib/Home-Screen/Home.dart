// ignore_for_file: library_private_types_in_public_api, sort_child_properties_last

import 'package:dlfood/Login-Screen/Login-main.dart';
import'package:dlfood/utils/css.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true); // Lặp lại animation và đảo ngược khi kết thúc
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food Delivery",
          style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,), // Sử dụng font cho tiêu đề
        ),
        backgroundColor: FontStyles.primaryColor, // Sử dụng màu cam cho app bar
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/main_logo.jpg',
                width: 150,
                height: 150,
              ),
            ),
           const SizedBox(height: 30),
            FadeTransition(
              opacity: _animation,
              child: Text(
                "Chào Mừng Đến Với Food Delivery!",
                style: FontStyles.titleStyle.copyWith(color: FontStyles.primaryColor), // Sử dụng font và màu từ font_styles.dart
                textAlign: TextAlign.center,
              ),
            ),
           const SizedBox(height: 30),
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.5),
                end: Offset.zero,
              ).animate(_animation),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child:const Text(
                  "Bắt Đầu",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: FontStyles.primaryColor, // Sử dụng màu cam cho nút
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}