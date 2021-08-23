import 'dart:async';
import 'package:firebase_ecommerce_app/constants.dart';
import 'package:firebase_ecommerce_app/screens/signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => RegistrationScreen(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.deep_orange,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'E-Commerce',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 44.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
