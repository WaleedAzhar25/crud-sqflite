import 'package:crud_sqflite_project/screens/admin/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // set time to load new page
    Future.delayed(const Duration(seconds:4 ),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const AdminPage()));
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
          height: 300,width: 300,child: Lottie.asset('images/sp.json'),),
          const SizedBox(height: 30,),
          SizedBox(height: 100,width: 100,child: Lottie.asset('images/a.json'),)
        ],
      ),
    ));
  }
}
