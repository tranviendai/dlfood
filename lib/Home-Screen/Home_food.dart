// ignore_for_file: camel_case_types, library_private_types_in_public_api, non_constant_identifier_names, sized_box_for_whitespace, sort_child_properties_last
import 'package:dlfood/Category/category.dart';
import 'package:dlfood/Data/favouriteLocal.dart';
import 'package:dlfood/Home-Screen/Detail_food.dart';
import 'package:dlfood/Home-Screen/Favorite_food.dart';
import 'package:dlfood/Home-Screen/InfoUser.dart';
import 'package:dlfood/Home-Screen/OrderHistory.dart';
import 'package:dlfood/Home-Screen/ShoppingCar.dart';
import 'package:dlfood/Product/product.dart';
import 'package:dlfood/models/cart.dart';
import 'package:dlfood/models/category.dart';
import 'package:dlfood/models/product.dart';
import 'package:dlfood/models/user.dart';
import 'package:dlfood/utils/css.dart';
import 'package:flutter/material.dart';

class Home_food extends StatefulWidget {
  final User user;
  final String token;
  final List<CategoryModel> category;
  final List<ProductModel> product;
  const Home_food(
      {super.key,
      required this.user,
      required this.token,
      required this.product,
      required this.category});

  @override
  _Home_foodState createState() => _Home_foodState();
}

class _Home_foodState extends State<Home_food> {
  final DbFavourite _databaseService = DbFavourite();
  List<CategoryModel> category = [];
  List<ProductModel> product = [];
  List<String> favoriteFoods = [];
  int _currentIndex = 0;
  Future<void> _onSave(ProductModel pro) async {
    _databaseService.insertProduct(TempModel(productID: pro.id,name: pro.name, des: pro.description, price: pro.price, img: pro.imageUrl, count: 1));
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    category = widget.category;
    product = widget.product;
  }




  Widget _favoriteFoodScreen() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: FavoureiteScreen(),
    );
  }

  Widget _OrderHistory() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: OrderHistoryScreen(token: widget.token),
    );
  }

  Widget _accountDetailsScreen() {
    return AccountDetailsScreen(
      user: widget.user,
      token: widget.token,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Delivery',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: FontStyles.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: IndexedStack(
          index: _currentIndex,
          children: [
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration.collapsed(
                                hintText: 'Tìm kiếm món ăn bạn muốn ?',
                                hintStyle: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                   const Text(
                            'Danh mục hiện có',
                            style: FontStyles.titleStyle,
                          ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      child: category.length == 0
                          ? Text("Chưa có dữ liệu")
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: category.length,
                              itemBuilder: (context, index) {
                                var data = category[index];
                                return GestureDetector(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8),
                                              ),
                                              child: Image.network(
                                                data.imageUrl,
                                                height: 120,
                                                width: 200,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.name,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    data.desc,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 16),
                        const Text(
                      'Món ăn phổ biến',
                      style: FontStyles.titleStyle,
                    ),
                    const SizedBox(height: 16),
                    product.length == 0
                        ? Text("Chưa có dữ liệu")
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: product.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = product[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detail_food(
                                              user: widget.user,
                                              category: widget.category,
                                              token: widget.token,
                                              product: product,
                                              data: data,
                                            )),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                     
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          data.imageUrl,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              'Đánh giá: 4.5 ★',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              'Khoảng cách: 1.7km',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              'Thời gian giao hàng: 32 phút',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FutureBuilder<List<TempModel>>(
                                        future: _databaseService.products(),
                                        builder:  (context, snapshot) {
                                          bool check = snapshot.data!.where((element) => element.productID == data.id).length == 0;
                                          return IconButton(icon: Icon( check ? Icons.favorite_outline_outlined : Icons.favorite), onPressed: () {
                                            check?  _onSave(data) : setState(() {
                                              _databaseService.deleteProduct(data.id);
                                            });;
                                          });
                                        })
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
            _favoriteFoodScreen(),
            _OrderHistory(),
            _accountDetailsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: FontStyles.primaryColor,
        unselectedItemColor: Colors.grey[600],
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Điều hướng đến màn hình Shopping Cart khi FAB được nhấn
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShoppingCartScreen(
                    user: widget.user,
                    token: widget.token,
                    category: widget.category,
                    product: widget.product)),
          );
        },
        child: const Icon(Icons.shopping_cart),
        backgroundColor: Colors.orangeAccent, // Màu nền cho FAB
      ),
    );
  }
}
