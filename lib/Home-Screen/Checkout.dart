// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:dlfood/Home-Screen/PaymentMethodScreen.dart'; // Import PaymentMethodScreen if not already imported
import 'package:dlfood/Home-Screen/PaymentSuccessScreen.dart';
import 'package:dlfood/Home-Screen/ShoppingCar.dart'; // Import ShoppingCar if not already imported
import 'package:dlfood/Home-Screen/Updateinfo.dart'; // Import Updateinfo if not already imported
import 'package:dlfood/models/category.dart';
import 'package:dlfood/models/product.dart';
import 'package:dlfood/models/user.dart';
import 'package:dlfood/utils/css.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final User user;
  final List<CategoryModel> category;
  final String token;
  final List<ProductModel> product;
  final Customer customer;

  CheckoutScreen({required this.product, required this.customer, required this.user, required this.token, required this.category});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Customer _customer;
  String selectedPaymentMethod = '';

  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    int totalItems = widget.product.length; // Tính tổng số món hàng

    // widget.product.forEach((product) {
    //   total += product.price * product.quantity;
    // });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thanh Toán',
          style: FontStyles.titleStyle, // Sử dụng font cho tiêu đề
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Bo tròn góc dưới của app bar
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Thêm lề cho toàn bộ nội dung của màn hình
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: FontStyles.primaryColor, // Sử dụng màu cam cho phần tiêu đề
                borderRadius: BorderRadius.circular(12), // Bo tròn góc của container
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Thông tin khách hàng',
                style: FontStyles.titleStyle.copyWith(color: Colors.white), // Sử dụng font và màu từ font_styles.dart
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // Bo tròn góc của container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Độ đổ bóng của container
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tên: ${_customer.name}', style: TextStyle(color: Colors.black)),
                    Text('Địa chỉ: ${_customer.address}', style: TextStyle(color: Colors.black)),
                    Text('Số điện thoại: ${_customer.phone}', style: TextStyle(color: Colors.black)),
                    SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAddressScreen(
                              onSaveAddress: (updatedCustomer) {
                                setState(() {
                                  _customer = updatedCustomer;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: Text('Cập nhật thông tin', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: FontStyles.primaryColor, // Sử dụng màu cam cho nút
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: FontStyles.primaryColor, // Sử dụng màu cam cho phần tiêu đề
                borderRadius: BorderRadius.circular(12), // Bo tròn góc của container
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Giỏ Hàng',
                style: FontStyles.titleStyle.copyWith(color: Colors.white), // Sử dụng font và màu từ font_styles.dart
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // Bo tròn góc của container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Độ đổ bóng của container
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: widget.product.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8), // Thêm khoảng trắng giữa các item
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(widget.product[index].imageUrl),
                          radius: 30,
                        ),
                        title: Text(widget.product[index].name, style: TextStyle(color: Colors.black)),
                        subtitle: Text(
                          '${widget.product[index].price.toString()}/VNĐ x 1',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng Cộng (${totalItems.toString()} món):', // Hiển thị tổng số món hàng
                  style: FontStyles.contentStyle.copyWith(fontWeight: FontWeight.bold), // Sử dụng font và màu từ font_styles.dart
                ),
                Text(
                  '$total/VNĐ',
                  style: FontStyles.contentStyle.copyWith(fontWeight: FontWeight.bold), // Sử dụng font và màu từ font_styles.dart
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentMethodScreen(),
                        ),
                      );

                      // Kiểm tra xem kết quả có rỗng hay không
                      if (result != null) {
                        setState(() {
                          selectedPaymentMethod = result; // Cập nhật phương thức thanh toán đã chọn
                        });

                        // Nếu đã chọn phương thức thanh toán, hiển thị dialog thanh toán thành công
                        if (selectedPaymentMethod.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Đang xử Lý Thanh Toán...'),
                                content: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(FontStyles.primaryColor), // Sử dụng màu cam cho indicator
                                ), // Hiển thị indicator loading
                                actions: [], // Không có nút "Continue" trong dialog này
                              );
                            },
                          );
                          // Giả lập xử lý thanh toán trong 2 giây
                          await Future.delayed(Duration(seconds: 2));
                          // Sau khi xử lý thanh toán xong, đóng dialog và chuyển sang màn hình thành công
                          Navigator.of(context).pop(); // Đóng dialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentSuccessScreen(user: widget.user,token: widget.token,product: widget.product, category: widget.category,),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FontStyles.primaryColor, // Sử dụng màu cam cho nút
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        selectedPaymentMethod.isNotEmpty ? 'Thanh toán cho $selectedPaymentMethod' : 'Chọn phương thức thanh toán',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
