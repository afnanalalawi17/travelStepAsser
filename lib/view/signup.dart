import 'package:flutter/material.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';
import 'package:travel_step/view/login.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {var heightApp = MediaQuery.of(context).size.height;
  var widthApp = MediaQuery.of(context).size.width;
    // final primaryColor = const Color(0xFF7B4CC7); // بنفسجي خطوة سفر

    return Scaffold(

      // backgroundColor: const Color(0xFFfbfae9),
      body:

          // 📄 محتوى الشاشة
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),

                const SizedBox(height: 24),
                const Text(
                  "إنشاء حساب جديد",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'IBMPlexSansArabic',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "يرجى تعبئة البيانات التالية لإنشاء حسابك في خطوة سفر",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // 🔹 الاسم الكامل
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'الاسم الكامل',
                    prefixIcon: Icon(Icons.person, color:  Color(0xff764880)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 16),

                // 🔹 رقم الجوال
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'رقم الجوال',
                    prefixIcon: Icon(Icons.phone_android, color:  Color(0xff764880)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 16),

                // 🔹 البريد الإلكتروني
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني',
                    prefixIcon: Icon(Icons.email_outlined, color:  Color(0xff764880)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 16),

                // 🔹 كلمة المرور
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'كلمة المرور',
                    prefixIcon: Icon(Icons.lock_outline, color:  Color(0xff764880)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 16),

                // 🔹 تأكيد كلمة المرور
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'تأكيد كلمة المرور',
                    prefixIcon: Icon(Icons.lock_outline, color:  Color(0xff764880)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 24),

                // 🔘 زر إنشاء الحساب
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CustomTabBar()));
                      // TODO: تنفيذ تسجيل الحساب
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xff764880),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "إنشاء الحساب",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 🔁 لديك حساب؟
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("هل لديك حساب؟"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                        // الانتقال إلى شاشة تسجيل الدخول
                      },
                      child: Text("تسجيل الدخول", style: TextStyle(color: Color(0xff764880))),
                    )
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
