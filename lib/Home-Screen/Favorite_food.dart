// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:dlfood/Data/favouriteLocal.dart';
import 'package:dlfood/models/cart.dart';
import 'package:flutter/material.dart';

class FavoureiteScreen extends StatefulWidget {
  const FavoureiteScreen({super.key});

  @override
  State<FavoureiteScreen> createState() => _FavoureiteScreenState();
}

class _FavoureiteScreenState extends State<FavoureiteScreen> {
 final DbFavourite _databaseHelper = DbFavourite();

  Future<List<TempModel>> _getProducts() async {
    return await _databaseHelper.products();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TempModel>>(
          future: _getProducts(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data![index].img),
                        ),
                        title: Text(
                          snapshot.data![index].name,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () {
                            setState(() {
                              _databaseHelper.deleteProduct(snapshot.data![index].productID);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}