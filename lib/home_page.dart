import 'package:doitright/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "", password = "";

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final keyPassword = 'password';
    final keyName = 'name';

    final valueName = prefs.get(keyName);
    final valuePassword = prefs.get(keyPassword);

    setState(() {
      name = valueName.toString();
      password = valuePassword.toString();

      print("valueName : $valueName");
      print("valuePassword : $valuePassword");
    });
  }

  _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _read();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg_home.png'), fit: BoxFit.fill)),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage()),
                    );
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(250)),
                      child: Center(
                        child: Text(
                          "إبدأ اللعب",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  right: 15,
                  left: 15,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _logout();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon_logout.png',
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                width: 125,
                                height: 40,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    "تسحيل الخروج",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon_user.png',
                                width: 100,
                                height: 100,
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                // width: 100,
                                height: 40,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
