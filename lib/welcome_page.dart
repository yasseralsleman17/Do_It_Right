import 'package:doitright/home_page.dart';
import 'package:doitright/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  String userName = "";
  String password = "";

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final keyPassword = 'password';
    final keyName = 'name';

    final valueName = prefs.get(keyName);
    final valuePassword = prefs.get(keyPassword);

    setState(() {
      userName = valueName.toString();
      password = valuePassword.toString();
      userName  !="null"?
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      ):
          print("first login");
      print("valueName : $valueName");
      print("valuePassword : $valuePassword");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _read();
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
              fit: BoxFit.fill
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 75,
              ),
              Text("مرحبا بك يا صديقي",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              ),),

              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width *0.9,
                  color: Colors.green,
                  child: Center(
                    child: Text("سجل دخولك",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width *0.9,
                  color: Colors.green,
                  child: Center(
                    child: Text("أنشئ حسابك الآن",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),),
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
