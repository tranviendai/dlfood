import 'package:dlfood/Data/Api.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
 final TextEditingController account = TextEditingController();
 final TextEditingController numberID = TextEditingController();
 final TextEditingController newPass = TextEditingController();

  submit() async{
   bool check =  await APIRepository().forgotPass(account.text,numberID.text,newPass.text);
   check ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cập nhật pass thành công"))) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sai thông tin rùi")));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quên mật khẩu"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: account,
                  decoration: InputDecoration(
                label: Text('tài khoản')
              ),
            ),
             TextField(
              controller: numberID,
                  decoration: InputDecoration(
                label: Text('CCCD/CMND')
              ),
            ),
             TextField(
              controller: newPass,
              decoration: InputDecoration(
                label: Text('mật khẩu mới')
              ),
            ),
            ElevatedButton(onPressed: (){
              submit();
            }, child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}