// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedPaymentMethod = ''; // Biến lưu trữ phương thức thanh toán đã chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn phương thức thanh toán',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
         backgroundColor: Colors.orangeAccent,
      ),
      body: ListView(
        children: [
          PaymentMethodTile(
            icon: Icons.payment,
            title: 'Thanh toán thẻ ',
            onTap: () {
              _selectPaymentMethod(context, 'Credit/Debit Card');
            },
          ),
          PaymentMethodTile(
            icon: Icons.monetization_on,
            title: 'Thanh toán tiền mặc',
            onTap: () {
              _selectPaymentMethod(context, 'Cash on Delivery (COD)');
            },
          ),
          PaymentMethodTile(
            icon: Icons.account_balance,
            title: 'Thanh toán ngân hàng',
            onTap: () {
              _selectPaymentMethod(context, 'Bank Transfer');
            },
          ),
          PaymentMethodTile(
            icon: Icons.phone_android,
            title: 'Thanh toán momo',
            onTap: () {
              _selectPaymentMethod(context, 'Momo');
            },
          ),
        ],
      ),
    );
  }

  void _selectPaymentMethod(BuildContext context, String paymentMethod) {
  Navigator.pop(context, paymentMethod);
}

}

class PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const PaymentMethodTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap as void Function()?,
    );
  }
}
