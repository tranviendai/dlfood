import 'package:dlfood/Data/Api.dart';
import 'package:dlfood/Home-Screen/Home_admin.dart';
import 'package:dlfood/Home-Screen/Home_food.dart';
import 'package:dlfood/models/category.dart';
import 'package:dlfood/models/product.dart';
import 'package:dlfood/models/user.dart';
import 'package:flutter/material.dart';

class ProductAdd extends StatefulWidget {
  final bool isUpdate;
  final ProductModel? productModel;
  final String token;
  final User user;
  final List<CategoryModel> category;
  const ProductAdd({super.key, this.isUpdate = false, this.productModel, required this.category, required this.token, required this.user});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  String? selectedCate;
  List<CategoryModel> categorys = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  final TextEditingController _catIdController = TextEditingController();
  String titleText = "";

  Future<void> _onSave() async {
    final name = _nameController.text;
    final des = _desController.text;
    final price = double.parse(_priceController.text);
    final img = _imgController.text;
    final catId = _catIdController.text;
    await APIRepository().addProduct(
        ProductModel(
            id: 0,
            name: name,
            imageUrl: img,
            categoryId: int.parse(catId),
            categoryName: '',
            price: price,
            description: des),
        widget.token);
    var list = await APIRepository().getProduct(widget.user.accountId!, widget.token);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Admin(user: widget.user, token: widget.token, product: list, category: widget.category)));
  }

  Future<void> _onUpdate() async {
    final name = _nameController.text;
    final des = _desController.text;
    final price = double.parse(_priceController.text);
    final img = _imgController.text;
    final catId = _catIdController.text;
    //update
    await APIRepository().updateProduct(
        ProductModel(
            id: widget.productModel!.id,
            name: name,
            imageUrl: img,
            categoryId: int.parse(catId),
            categoryName: '',
            price: price,
            description: des),
        widget.user.accountId!,
        widget.token);
    var list = await APIRepository().getProduct(widget.user.accountId!, widget.token);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home_Admin(user: widget.user, token: widget.token, product: list, category: widget.category)));
  }

  _getCategorys() async {
    var temp = await APIRepository().getCategory(
        widget.user.accountId!,
        widget.token);
    setState(() {
      selectedCate = temp.first.id.toString();
      _catIdController.text = selectedCate.toString();
      categorys = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategorys();

    if (widget.productModel != null && widget.isUpdate) {
      _nameController.text = widget.productModel!.name;
      _desController.text = widget.productModel!.description;
      _priceController.text = widget.productModel!.price.toString();
      _imgController.text = widget.productModel!.imageUrl;
      _catIdController.text = widget.productModel!.categoryId.toString();
    }
    if (widget.isUpdate) {
      titleText = "Update Product";
    } else
      titleText = "Add New Product";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Name:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter name',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Price:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter price',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Image:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _imgController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter imageURL',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Desciption:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _desController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter description',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Category:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 50, color: Colors.white))),
                value: selectedCate,
                items: categorys
                    .map((item) => DropdownMenuItem<String>(
                          value: item.id.toString(),
                          child: Text(item.name,
                              style: const TextStyle(fontSize: 20)),
                        ))
                    .toList(),
                //onChanged: (item) => setState(() => selectedCate = item),
                onChanged: (item) {
                  // final selectedCategoryId = int.tryParse(item ?? '');
                  setState(() {
                    selectedCate = item;
                    _catIdController.text = item.toString();
                    print(_catIdController.text);
                  });
                },
              ),
              //image
              const SizedBox(height: 16.0),
              const SizedBox(height: 20),
              SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    widget.isUpdate ? _onUpdate() : _onSave();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}