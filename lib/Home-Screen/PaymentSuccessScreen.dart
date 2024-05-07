// ignore_for_file: unnecessary_const
import 'package:dlfood/Home-Screen/Home_food.dart';
import 'package:dlfood/Home-Screen/ShoppingCar.dart';
import 'package:dlfood/models/category.dart';
import 'package:dlfood/models/product.dart';
import 'package:dlfood/models/user.dart';
import 'package:flutter/material.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final List<CategoryModel> category;
  final User user;
  final String token;
  final List<ProductModel> product;
  const PaymentSuccessScreen({Key? key, required this.user, required this.token, required this.product, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thanh Toán Thành Công',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle, // Icon thành công
                color: Colors.green, // Màu xanh cho icon
                size: 100, // Kích thước của icon
              ),
              const SizedBox(height: 20), // Khoảng cách giữa icon và text
              Text(
                'Cảm ơn bạn đã tin tưởng sử dụng dịch vụ của chúng tôi, chúng tôi sẽ giao hàng cho bạn trong thời gian sớm nhất',
                textAlign: TextAlign.center, // Căn giữa văn bản
                style: TextStyle(
                  fontSize: 20, // Kích thước văn bản
                ),
              ),
              const SizedBox(height: 20), // Khoảng cách giữa text và bottom
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home_food(user: user, token: token,product: product,category: category),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
