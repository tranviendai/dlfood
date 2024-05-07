import 'package:dlfood/Data/Api.dart';
import 'package:dlfood/Home-Screen/Home_admin.dart';
import 'package:dlfood/Home-Screen/Home_food.dart';
import 'package:dlfood/models/product.dart';
import 'package:dlfood/models/category.dart';
import 'package:dlfood/models/user.dart';
import 'package:flutter/material.dart';

class CategoryAdd extends StatefulWidget {
  final User user;
  final bool isUpdate;
  final String token;
  final List<ProductModel> product;
  final CategoryModel? categoryModel;
  const CategoryAdd({super.key,this.isUpdate = false, this.categoryModel, required this.user, required this.token, required this.product});

  @override
  State<CategoryAdd> createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String titleText = "";
  Future<void> _onSave() async {
    final name = _nameController.text;
    final description = _descController.text;
    final image = _imageController.text;
    await APIRepository().addCategory(
        CategoryModel(id: 0, name: name, imageUrl: image, desc: description),
        widget.user.accountId!,
        widget.token);
    // await _databaseService
    //     .insertCategory(CategoryModel(name: name, desc: description));
   var listCategory = await APIRepository().getCategory(widget.user.accountId!, widget.token);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Admin(user: widget.user, token: widget.token, product: widget.product, category: listCategory)));
  }

  Future<void> _onUpdate(int id) async {
    final name = _nameController.text;
    final description = _descController.text;
    final image = _imageController.text;
    //update
    await APIRepository().updateCategory(
        id,
        CategoryModel(id: widget.categoryModel!.id, name: name, imageUrl: image, desc: description),
        widget.user.accountId!,
        widget.token);
    var listCategory = await APIRepository().getCategory(widget.user.accountId!, widget.token);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Admin(user: widget.user, token: widget.token, product: widget.product, category: listCategory)));
  }

  @override
  void initState() {
    super.initState();
    if (widget.categoryModel != null && widget.isUpdate) {
      _nameController.text = widget.categoryModel!.name;
      _descController.text = widget.categoryModel!.desc;
      _imageController.text = widget.categoryModel!.imageUrl;
    }
    if (widget.isUpdate) {
      titleText = "Update Category";
    } else
      titleText = "Add New Category";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter name',
              ),
            ),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter imageURL',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descController,
              maxLines: 7,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter description',
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 45.0,
              child: ElevatedButton(
                onPressed: () {
                  widget.isUpdate
                      ? _onUpdate(widget.categoryModel!.id)
                      : _onSave();
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}