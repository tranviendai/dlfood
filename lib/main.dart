import 'package:dlfood/Home-Screen/Home.dart'; // Import màn hình Home
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay chuyển sang màn hình Home
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()), // Chuyển sang màn hình Home
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Food Delivery",style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Loading...', // Hiển thị chữ Loading...
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator( // Hiển thị CircularProgressIndicator
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent), // Sử dụng màu trắng cho CircularProgressIndicator
              ),
            ],
          ),
        ),
      ),
    );
  }
}
