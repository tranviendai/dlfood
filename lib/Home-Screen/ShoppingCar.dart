import 'package:dlfood/Data/Api.dart';
import 'package:dlfood/Data/cartLocal.dart';
import 'package:dlfood/Home-Screen/Checkout.dart';
import 'package:dlfood/Home-Screen/Home_food.dart';
import 'package:dlfood/Home-Screen/Updateinfo.dart';
import 'package:dlfood/models/cart.dart';
import 'package:dlfood/models/category.dart';
import 'package:dlfood/models/product.dart';
import 'package:dlfood/models/user.dart';
import'package:dlfood/utils/css.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MyApp extends StatelessWidget {
  final String token;
  final List<CategoryModel> category;
  final User user;
  final List<ProductModel> product;
  const MyApp({super.key, required this.token,required this.user, required this.product, required this.category});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIỎ HÀNG',
      theme: ThemeData(
        primaryColor: FontStyles.primaryColor, // Sử dụng màu cam cho header từ FontStyles
        primarySwatch: Colors.blue,
      ),
      home: ShoppingCartScreen(user: user, token: token, product: product, category: category),
    );
  }
}

class ShoppingCartScreen extends StatefulWidget {
  final User user;
  final String token;
  final List<CategoryModel> category;
  final List<ProductModel> product;
  const ShoppingCartScreen({super.key, required this.token, required this.user, required this.product, required this.category});

  @override
  // ignore: library_private_types_in_public_api
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final DbCart _databaseHelper = DbCart();

  Future<List<TempModel>> _getProducts() async {
    return await _databaseHelper.products();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng', style: FontStyles.titleStyle), // Sử dụng font chữ cho tiêu đề từ FontStyles
        backgroundColor: FontStyles.primaryColor, // Sử dụng màu cam cho header từ FontStyles
      ),
      body: FutureBuilder<List<TempModel>>(
        future: _getProducts(),
        builder: (context, snapshot) {
          var _cartItems = snapshot.data!;
          return ListView.builder(
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(_cartItems[index].img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  _cartItems[index].name,
                  style: FontStyles.titleStyle, // Sử dụng font chữ cho tiêu đề từ FontStyles
                ),
                subtitle: Text(
                  '${_cartItems[index].price.toString()}/VNĐ',
                  style: FontStyles.contentStyle, // Sử dụng font chữ cho nội dung từ FontStyles
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                                DbCart().minus(_cartItems[index]);
                        });
                        if(_cartItems[index].count < 2) {
                          setState(() {
                            DbCart().deleteProduct(_cartItems[index].productID);
                          });
                        }
                      },
                    ),
                    Text(_cartItems[index].count.toString(), style: FontStyles.contentStyle), // Sử dụng font chữ cho nội dung từ FontStyles
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                         setState(() {
                               DbCart().add(_cartItems[index]);
                         });
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home_food(user: widget.user, token: widget.token,product: widget.product,category: widget.category)),
          );
        },
        // ignore: sort_child_properties_last
        child: const Icon(Icons.home),
        backgroundColor: FontStyles.primaryColor, // Sử dụng màu cam cho nút floating action button từ FontStyles
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder<List<TempModel>>(
                future: _getProducts(),
                builder: (context, snapshot) {
                  double total = snapshot.data!.fold(0, (total, current) => total + current.price! * current.count);
                  return Text(
                    'total: ${total}VNĐ',
                    style: FontStyles.contentStyle, // Sử dụng font chữ cho nội dung từ FontStyles
                  );
                }
              ),
              FloatingActionButton.extended(
                onPressed: () async {
                      List<TempModel> temp = await _databaseHelper.products();
                   await APIRepository().addBill(temp,widget.token);
                       setState(() {
                          _databaseHelper.clear(); 
                        });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CheckoutScreen(
                  //       product: _cartItems,
                  //       customer: Customer(name: 'Tên khách hàng', address: 'Địa chỉ', phone: 'Số điện thoại'),
                  //       user: widget.user,
                  //       token: widget.token,
                  //     ),
                  //   ),
                  // );
                },
                label: const Text('Thanh Toán'),
                icon: const Icon(Icons.shopping_cart),
                backgroundColor: FontStyles.primaryColor, // Sử dụng màu cam cho nút floating action button từ FontStyles
              ),
            ],
          ),
        ),
      ),
    );
  }
}

