// ignore_for_file: sized_box_for_whitespace

import 'package:dlfood/Data/cartLocal.dart';
import 'package:dlfood/Home-Screen/ShoppingCar.dart';
import 'package:dlfood/models/cart.dart';
import 'package:dlfood/models/category.dart';
import 'package:dlfood/models/product.dart';
import 'package:dlfood/models/user.dart';
import'package:dlfood/utils/css.dart';
import 'package:flutter/material.dart';



class Detail_food extends StatefulWidget {
  final String token;
  final User user;
  final List<ProductModel> product;
  final ProductModel data;
  final List<CategoryModel> category;
  const Detail_food({super.key, required this.user, required this.token, required this.product, required this.data, required this.category});

  @override
  State<Detail_food> createState() => _Detail_foodState();
}

class _Detail_foodState extends State<Detail_food> {
   int quantity = 1;
    final DbCart _databaseService = DbCart();
  int price = 0; // Giá tiền mặc định là 50000Đ
  int defaultPrice = 0; // Giá tiền mặc định là 50000Đ
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    price = widget.data.price;
    defaultPrice = widget.data.price;
  }
  void incrementQuantity() {
    setState(() {
      quantity++;
      price = quantity * defaultPrice; // Mỗi lần cộng, tăng giá tiền lên 50000Đ
    });
  }
  Future<void> _onSave(ProductModel pro) async {
    _databaseService.insertProduct(TempModel(productID: pro.id,name: pro.name, des: pro.description, price: pro.price, img: pro.imageUrl, count: 1));
    setState(() {});
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        price = quantity * defaultPrice; // Mỗi lần trừ, giảm giá tiền đi 50000Đ
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết món ăn',
          style: TextStyle(
            color: Colors.white, // Đặt màu chữ thành trắng
          ),
        ),
        backgroundColor: FontStyles.primaryColor, // Sử dụng màu cam cho app bar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    child: Image.network(
                      widget.data.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.name,
                          style: FontStyles.titleStyle.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              '★★★★★',
                              style: TextStyle(
                                color: Color(0xFFFFBD8E),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '4.5',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '1234 comment',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '4.5 ★',
                              style: FontStyles.contentStyle.copyWith(fontSize: 16),
                            ),
                            Text(
                              '1.7km',
                              style: FontStyles.contentStyle.copyWith(fontSize: 16),
                            ),
                            Text(
                              '32min',
                              style: FontStyles.contentStyle.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Giới Thiệu',
                          style: FontStyles.titleStyle.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 8),
                        Text(
                         widget.data.description,
                          style: FontStyles.contentStyle.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: decrementQuantity,
                        ),
                        Text(
                          quantity.toString(),
                          style: FontStyles.contentStyle.copyWith(fontSize: 20),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: incrementQuantity,
                        ),
                      ],
                    ),
                    Text(
                      '$price VNĐ', // Hiển thị giá tiền
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Khoảng trống
                ElevatedButton(
                  onPressed: ()  {
                    _onSave(widget.data);
                  Future.delayed(Duration(milliseconds: 1),(){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShoppingCartScreen(user: widget.user, token: widget.token,product: widget.product,category: widget.category,)),
                    );
                  });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    backgroundColor: FontStyles.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Add To Cart',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}