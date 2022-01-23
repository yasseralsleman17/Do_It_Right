import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db_helper.dart';
import 'home_page.dart';
import 'user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  String userName = "", password = "";

  _saveLoginInfo(String name, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final keyName = 'name';
    final keyPassword = 'password';

    final valueName = name;
    final valuePassword = password;

    prefs.setString(keyName, valueName);
    prefs.setString(keyPassword, valuePassword);
  }

  void btnLogin() {
    if (_nameController.text.isEmpty || _passwordController.text.isEmpty) {
      Fluttertoast.showToast(  msg: "الرجاء ملئ الحقول بالقيم المناسبة",
          toastLength: Toast.LENGTH_SHORT,   backgroundColor: Colors.black,
          textColor: Colors.white,   fontSize: 16.0);
    } else {
      checkUser(_nameController.text);
    }}

  void checkUser(String name) async {
    try {
      List userList =
          await DatabaseHelper.instance.searchUser(name.toString().trim());
      print(userList);
      if (userList.length > 0) {
        userName = userList[0][UserModel.NAME];
        password = userList[0][UserModel.PASSWORD];
        if (_nameController.text == userName &&
            _passwordController.text == password) {
          Fluttertoast.showToast(  msg: "تم تسجيل الدخول بنجاح",
              toastLength: Toast.LENGTH_SHORT,  backgroundColor: Colors.black,
              textColor: Colors.white,  fontSize: 16.0);
          _nameController.clear();
          _passwordController.clear();
          _saveLoginInfo(userName, password);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          Fluttertoast.showToast( msg: "اليانات المدخلة غير صحيحة",
              toastLength: Toast.LENGTH_SHORT,  backgroundColor: Colors.black,
              textColor: Colors.white,  fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast( msg: "الحساب المدخل غير موجود",
            toastLength: Toast.LENGTH_SHORT,  backgroundColor: Colors.black,
            textColor: Colors.white,  fontSize: 16.0);
      }
    } catch (ex) { print(ex);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg_welcome.png'),
                  fit: BoxFit.fill)),
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
              TextButton(
                onPressed: btnLogin,
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      "سجل دخولك",
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
    );
  }
}
