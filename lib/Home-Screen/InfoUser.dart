import 'package:dlfood/Data/Api.dart';
import 'package:dlfood/Login-Screen/Login-main.dart';
import 'package:dlfood/models/register.dart';
import 'package:dlfood/models/user.dart';
import 'package:dlfood/utils/css.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final User user;
  final String token;
  const MyApp({super.key, required this.token, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account Details',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: AccountDetailsScreen(user: user, token: token),
    );
  }
}

class AccountDetailsScreen extends StatefulWidget {
  final String token;
  final User user;

  const AccountDetailsScreen(
      {super.key, required this.user, required this.token});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  bool showPass1 = false;
  bool showPass2 = false;
  @override
  void initState() {
    super.initState();
    user = widget.user;
    _fullNameController.text = user.fullName!;
    _numberIDController.text = user.idNumber!;
    _birthDayController.text = user.birthDay!;
    _phoneNumberController.text = user.phoneNumber!;
    _imageURL.text = user.imageURL!;
    _schoolKeyController.text = user.schoolKey!;
    _schoolYearController.text = user.schoolYear!;
  }

  int _gender = 0;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _imageURL = TextEditingController();
  String gendername = 'None';

  Future<String> profilePut() async {
    return await APIRepository().updateProfile(
        Signup(
            accountID: '',
            birthDay: _birthDayController.text,
            password: '',
            confirmPassword: '',
            fullName: _fullNameController.text,
            phoneNumber: _phoneNumberController.text,
            schoolKey: _schoolKeyController.text,
            schoolYear: _schoolYearController.text,
            gender: getGender(),
            imageUrl: _imageURL.text,
            numberID: _numberIDController.text),
        widget.token);
  }
   Future<String> passwordPut() async {
    return await APIRepository().updatePass(_oldPasswordController.text,_newPasswordController.text,widget.token);
  }

  getGender() {
    if (_gender == 1) {
      return "Male";
    } else if (_gender == 2) {
      return "Female";
    }
    return "Other";
  }

  int toggle = 1;
  User user = User(
      idNumber: '',
      accountId: '',
      fullName: '',
      phoneNumber: '',
      imageURL: '',
      birthDay: '',
      gender: '',
      schoolYear: '',
      schoolKey: '',
      dateCreated: '',
      status: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          toggle == 1
              ? Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        toggle = 3;
                      });
                    },
                    child: Text("Đổi mật khẩu"),
                  ),
                )
              : SizedBox(),
         toggle == 3 || toggle == 2 ? 
          Container(
            child: ElevatedButton(
              onPressed: () {
                  setState(() {
                    toggle = 1;
                  });
              },
              child: Text("Hồ sơ của tôi"),
            ),
          )
          :  Container(
            child: ElevatedButton(
              onPressed: () {
                  setState(() {
                    toggle = 2;
                  });
              },
              child: Text("Cập nhật hồ sơ"),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(child: toggle == 2 ? profileUpdate() : toggle == 1 ? profile() : passwordUpdate()),
    );
  }
 Widget passwordUpdate() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _oldPasswordController,
            obscureText: showPass1,
            decoration:  InputDecoration(
              labelText: 'Old password',
               suffixIcon: IconButton(onPressed: (){
                setState(() {
                  showPass1 = !showPass1;
                });
              }, icon: Icon(showPass1 ? Icons.remove_red_eye_outlined : Icons.remove_red_eye)),
              icon: Icon(Icons.lock),
            ),
          ),
          TextFormField(
            controller: _newPasswordController,
            obscureText: showPass2,
            decoration:  InputDecoration(
              labelText: 'New password',
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  showPass2 = !showPass2;
                });
              }, icon: Icon(showPass2? Icons.remove_red_eye_outlined : Icons.remove_red_eye)),
              icon: Icon(Icons.lock),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              String respone = await passwordPut();
              if (respone == "ok") {
                setState(() {
                  toggle = 1;
                });
                _oldPasswordController.clear();
                _newPasswordController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Cập nhật thành công")));
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 100), // Độ dài của nút
              backgroundColor: Colors.white,
              shadowColor: Colors.black.withOpacity(0.5), // Màu đổ bóng mờ
              elevation: 5, // Độ đổ bóng mờ
            ),
            child: const Text(
              'Cập nhật Mật khẩu',
              style: TextStyle(
                color: FontStyles.primaryColor, // Sử dụng màu chữ từ FontStyles
                fontWeight: FontWeight.bold, // Chữ in đậm
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileUpdate() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              String respone = await profilePut();
              if (respone == "ok") {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())); 
               });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Cập nhật thành công")));
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
              'Cập nhật',
              style: TextStyle(
                color: FontStyles.primaryColor, // Sử dụng màu chữ từ FontStyles
                fontWeight: FontWeight.bold, // Chữ in đậm
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profile() {
    return Column(
      children: [
        CircleAvatar(
          radius: 100,
          backgroundImage: NetworkImage(user.imageURL!),
        ),
        const SizedBox(height: 20),
        Card(
          elevation: 4, // Điều chỉnh giá trị độ nâng của card
          child: ListTile(
            leading: const Icon(Icons.abc),
            title: Text(
              user.fullName!,
              style: FontStyles
                  .titleStyle, // Sử dụng phong cách tiêu đề từ FontStyles
            ),
          ),
        ),
        Card(
          elevation: 4,
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text(
              user.gender!,
              style: FontStyles
                  .contentStyle, // Sử dụng phong cách nội dung từ FontStyles
            ),
          ),
        ),
        Card(
          elevation: 4,
          child: ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              user.phoneNumber!,
              style: FontStyles
                  .contentStyle, // Sử dụng phong cách nội dung từ FontStyles
            ),
          ),
        ),
        Card(
          elevation: 4,
          child: ListTile(
            leading: Icon(Icons.date_range),
            title: Text(
              user.birthDay!,
              style: FontStyles
                  .contentStyle, // Sử dụng phong cách nội dung từ FontStyles
            ),
          ),
        ),
              Card(
          elevation: 4,
          child: ListTile(
            leading: Icon(Icons.golf_course_outlined),
            title: Text(
              user.dateCreated!,
              style: FontStyles
                  .contentStyle, // Sử dụng phong cách nội dung từ FontStyles
            ),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) => LoginScreen()));
                      },
          icon: const Icon(Icons.logout, color: Colors.red),
          label: const Text(
            'Đăng Xuất',
            style: TextStyle(color: Colors.red), // Sử dụng màu chữ đỏ
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 4, // Điều chỉnh giá trị độ nâng của nút
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
