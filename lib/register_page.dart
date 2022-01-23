import 'package:doitright/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db_helper.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfirmController =
      new TextEditingController();

  _saveLoginInfo(String name, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final keyName = 'name';
    final keyPassword = 'password';

    final valueName = name;
    final valuePassword = password;

    prefs.setString(keyName, valueName);
    prefs.setString(keyPassword, valuePassword);
  }

  void btnRegister() async {
    if (_nameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "الرجاء ملئ الحقول بالقيم المناسبة",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (_passwordController.text != _passwordConfirmController.text) {
      Fluttertoast.showToast(
          msg: "كلمتا المرور غير متطابقتين",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      UserModel userModel = UserModel(
          id: null,
          name: _nameController.text,
          password: _passwordController.text);

      int result = await DatabaseHelper.instance.addUser(userModel);

      print("result of add :$result");

      if (result > 0) {
        _saveLoginInfo(_nameController.text, _passwordController.text);
        _nameController.clear();
        _passwordConfirmController.clear();
        _passwordController.clear();

        Fluttertoast.showToast(
            msg: "تم إنشاء حساب جديد بنجاخ",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Fluttertoast.showToast(
            msg: "هذا الاسم موجود مسبقا,اختر اسم آخر",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg_welcome.png'),
                  fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "مرحبا بك يا صديقي",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    textDirection: TextDirection.rtl,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      hintText: "الاسم",
                      hintStyle: TextStyle(color: Colors.black26),
                      contentPadding: EdgeInsets.all(0),
                      labelStyle: TextStyle(fontSize: 18),
                      // suffixIcon: icon,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    textDirection: TextDirection.rtl,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      hintText: "********",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                      contentPadding: EdgeInsets.all(0),
                      labelStyle: TextStyle(fontSize: 18),
                      // suffixIcon: icon,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _passwordConfirmController,
                    textDirection: TextDirection.rtl,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      hintText: "********",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                      contentPadding: EdgeInsets.all(0),
                      labelStyle: TextStyle(fontSize: 18),
                      // suffixIcon: icon,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextButton(
                  onPressed: btnRegister,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.green,
                    child: Center(
                      child: Text(
                        "إنشئ حسابك",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
