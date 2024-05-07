import 'package:dlfood/Data/Api.dart';
import 'package:dlfood/Login-Screen/Login-main.dart';
import 'package:dlfood/Login-Screen/OTPScreen.dart';
import 'package:dlfood/models/register.dart';
import'package:dlfood/utils/css.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    int _gender = 0;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _imageURL = TextEditingController();
  String gendername = 'None';

  Future<String> register() async {
    return await APIRepository().register(Signup(
        accountID: _accountController.text,
        birthDay: _birthDayController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
        schoolKey: _schoolKeyController.text,
        schoolYear: _schoolYearController.text,
        gender: getGender(),
        imageUrl: _imageURL.text,
        numberID: _numberIDController.text));
  }
  getGender() {
    if (_gender == 1) {
      return "Male";
    } else if (_gender == 2) {
      return "Female";
    }
    return "Other";
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,), // Sử dụng màu chữ từ FontStyles
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/main_logo.jpg',
                width: 150,
                height: 150,
              ),
              TextFormField(
                controller: _accountController,
                decoration: const InputDecoration(
                  labelText: 'Tài khoản',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
                       TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'FullName',
                  prefixIcon: Icon(Icons.abc),
                ),
              ),
                       TextFormField(
                controller: _numberIDController,
                decoration: const InputDecoration(
                  labelText: 'NumberID',
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: _confirmPasswordController,
                decoration : const InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
             const SizedBox(height: 20),
               TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
             const SizedBox(height: 20),
              TextFormField(
                controller: _birthDayController,
                decoration: const InputDecoration(
                  labelText: 'Birthday',
                  prefixIcon: Icon(Icons.date_range),
                ),
              ),
                  const SizedBox(height: 20),
              TextFormField(
                controller: _schoolYearController,
                decoration: const InputDecoration(
                  labelText: 'SchoolYear',
                  prefixIcon: Icon(Icons.school),
                ),
              ),
                  const SizedBox(height: 20),
              TextFormField(
                controller: _schoolKeyController,
                decoration: const InputDecoration(
                  labelText: 'SchoolKey',
                  prefixIcon: Icon(Icons.school),
                ),
              ),
                TextFormField(
                controller: _imageURL,
                decoration: const InputDecoration(
                  labelText: 'Image Url',
                  prefixIcon: Icon(Icons.image),
                ),
              ),
              const Text("What is your Gender?"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Male"),
                  leading: Transform.translate(
                      offset: const Offset(16, 0),
                      child: Radio(
                        value: 1,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      )),
                ),
              ),
              Expanded(
                child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text("Female"),
                    leading: Transform.translate(
                      offset: const Offset(16, 0),
                      child: Radio(
                        value: 2,
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    )),
              ),
              Expanded(
                  child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text("Other"),
                leading: Transform.translate(
                    offset: const Offset(16, 0),
                    child: Radio(
                      value: 3,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    )),
              )),
            ],
          ),
            const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                 String respone = await register();
                          if (respone == "ok") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          }
                  // Xử lý logic khi nhấn nút đăng ký ở đây
                  //  Navigator.push(
                  //    context,
                  //    MaterialPageRoute(builder: (context) => OTPScreen()),
                  //  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100), // Độ dài của nút
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black.withOpacity(0.5), // Màu đổ bóng mờ
                  elevation: 5, // Độ đổ bóng mờ
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: FontStyles.primaryColor, // Sử dụng màu chữ từ FontStyles
                    fontWeight: FontWeight.bold, // Chữ in đậm
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