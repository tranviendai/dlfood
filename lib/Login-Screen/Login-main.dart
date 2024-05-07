import 'package:dlfood/Data/api.dart';
import 'package:dlfood/Home-Screen/ForgotPass.dart';
import 'package:dlfood/Home-Screen/Home_admin.dart';
import 'package:dlfood/Home-Screen/Home_food.dart';
import 'package:dlfood/Login-Screen/RegisterScreen.dart';
import 'package:dlfood/models/product.dart';
import'package:dlfood/utils/css.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


Widget buildSignInButton(Buttons buttonType, String text, VoidCallback onPressed, String imagePath) {
  return OutlinedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(horizontal: 10.0)), // Tăng độ rộng của nút
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 24.0,
          width: 24.0,
        ),
        SizedBox(width: 8.0),
        Text(text),
      ],
    ),
  );
}

void handleGoogleSignIn() {
  // Xử lý đăng nhập bằng Google
}

void handleFacebookSignIn() {
  // Xử lý đăng nhập bằng Facebook
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController(text: "tester02");
  TextEditingController passwordController = TextEditingController(text: "123456");
  bool showPass = true;
  bool check = true;
  login() async {
    //lấy token (lưu share_preference)
    String token = await APIRepository().login(accountController.text, passwordController.text);
    var user = await APIRepository().current(token);
    var list = await APIRepository().getProduct(accountController.text, token);
    var listCategory = await APIRepository().getCategory(accountController.text, token);
    !check ? Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home_Admin(user: user, token: token, product: list,category: listCategory)))
     : Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home_food(user: user, token: token, product: list,category: listCategory)));
    return token;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Đăng Nhập",
          style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold,), // Sử dụng màu chữ từ FontStyles
        ),
        backgroundColor: FontStyles.primaryColor, // Sử dụng màu cam cho header từ FontStyles
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreen()));
          }, icon: Icon(Icons.battery_unknown_outlined))
        ],
      ),
      backgroundColor: Colors.white, // Đổi màu nền thành màu trắng
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/main_logo.jpg',
                  width: 150,
                  height: 150,
                ), // Thêm logo vào màn hình
               const SizedBox(height: 10),
               const Text(
                  'Chào Mừng Bạn',
                  style: FontStyles.titleStyle, // Sử dụng font style cho tiêu đề từ FontStyles
                ),
               const SizedBox(height: 5),
               const Text(
                  'Đăng Nhập Với Tài Khoản Của Bạn',
                  style: FontStyles.contentStyle, // Sử dụng font style cho nội dung từ FontStyles
                ),
              const  SizedBox(height: 20),
                TextField(
                  controller: accountController,
                  decoration: const InputDecoration(
                    labelText: 'Tài khoản',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
               const SizedBox(height: 20),
                TextField(
                  obscureText: showPass,
                  controller: passwordController,
                  decoration:  InputDecoration(
                    labelText: 'Mật Khẩu',
                   suffixIcon: IconButton(onPressed: (){
                setState(() {
                  showPass = !showPass;
                });
              }, icon: Icon(showPass? Icons.remove_red_eye_outlined : Icons.remove_red_eye)),
              icon: Icon(Icons.lock),
                  ),
                ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Admin?"),
                 IconButton(onPressed: (){
                  setState(() {
                    check = !check;
                  });
                }, icon: Icon( check? Icons.check_box_outline_blank_rounded : Icons.check_box))
               ],),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                   login();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 150), // Độ dài của nút
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black.withOpacity(0.5), // Màu đổ bóng mờ
                    elevation: 5, // Độ đổ bóng mờ
                  ),
                  child: const Text(
                    'Đăng Nhập',
                    style: TextStyle(
                      color: FontStyles.primaryColor, // Sử dụng màu chữ từ FontStyles
                      fontWeight: FontWeight.bold, // Chữ in đậm
                      fontSize: 18,
                    ),
                  ),
                ),
               const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const Text(
                      "Không Có Tài Khoản?",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        // Chuyển đến màn hình đăng ký
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'Đăng Ký',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
               const SizedBox(height: 5),
                buildSignInButton(Buttons.Google, "Đăng Nhập Với Google", handleGoogleSignIn, "assets/google_logo.png"),
               const SizedBox(height: 5),
                buildSignInButton(Buttons.Facebook, "Đăng Nhập Với Facebook", handleFacebookSignIn, "assets/facebook_logo.png"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}