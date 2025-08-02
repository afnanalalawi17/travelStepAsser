import 'package:flutter/material.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';
import 'package:travel_step/view/signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var heightApp = MediaQuery.of(context).size.height;
    var widthApp = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xFFfbfae9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Image.asset(
              'assets/images/logo.png', // ضع هنا صورة مشابهة لخلفية onboarding
              height: 180,
            ),
            const SizedBox(height: 24),
            const Text(
              "مرحباً بعودتك",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'IBMPlexSansArabic',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "أدخل بياناتك للمتابعة في خطوة سفر",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // 🟣 حقل البريد أو الجوال
            TextFormField(
              decoration: InputDecoration(

                hintText: 'رقم الجوال أو البريد الإلكتروني',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.person, color: Color(0xff764880)),
              ),
              textDirection: TextDirection.rtl,

            ),
            const SizedBox(height: 16),

            // 🔒 كلمة المرور
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'كلمة المرور',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.lock, color: Color(0xff764880)),
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 12),

            // رابط نسيت كلمة المرور؟
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "نسيت كلمة المرور؟",
                  style: TextStyle(color: Color(0xff764880)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // زر الدخول
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CustomTabBar()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff764880),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontSize: 18, color: Colors.white , fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // رابط التسجيل
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("ليس لديك حساب؟"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignUpScreen()));
                  },
                  child: Text(
                    "أنشئ حساب",
                    style: TextStyle(color: Color(0xff764880)),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.12,
                child: Image.asset(
                  "assets/images/step.png",
                  width: 400,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
