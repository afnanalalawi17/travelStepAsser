
import 'package:flutter/material.dart';
import 'package:travel_step/view/signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardItem> onboardingData = [
    OnboardItem(
      title: "مرحباً ألف في أبها",
      image: "assets/images/boarding1.png",
      desc: "دليلك لاكتشاف أفضل المعالم السياحية بأسلوب سهل وممتع",
    ),
    OnboardItem(
      title: "استكشف الأماكن",
      image: "assets/images/boarding2.png",
      desc: "معالم الطبيعة والأنشطة الممتعة لكل أفراد العائلة",
    ),
    OnboardItem(
      title: "نظم رحلتك",
      image: "assets/images/boarding3.png",
      desc: "خطط ومغامرات مصممة خصيصاً لك",
    ),
    OnboardItem(
      title: "أحجز بسهولة",
      image: "assets/images/boarding4.png",
      desc: "أحجز فندقك وانشطتك بكل سهولة وأمان",
    ),
  ];

  void nextPage()async {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      // final prefs = await SharedPreferences.getInstance();
      // prefs.remove('hasShownShowcase');
      Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SignUpScreen()));

      // Navigate to next screen or home
      print("انتهى التقديم 👋");
    }
  }

  void skip() {
    _controller.jumpToPage(onboardingData.length - 1);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {var heightApp = MediaQuery.of(context).size.height;
  var widthApp = MediaQuery.of(context).size.width;
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Color(0xFFfbfae9),
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final item = onboardingData[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: skip,
                          child: const Text("تخطي", style: TextStyle(color:Color(0xff764880) , fontFamily: "IBMPlexSansArabic"), ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          item.title,
                          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontFamily: "IBMPlexSansArabic"),
                        ),
                      ),
                      const SizedBox(height: 80),
                      Image.asset(
                          item.image, width: double.infinity,height: 300,fit: BoxFit.fill,
                      ),

                      const SizedBox(height: 80),
                      Text(
                        item.desc,
                        style: const TextStyle(fontSize: 16,fontFamily: "IBMPlexSansArabic"),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
               //    Directionality(
               //    textDirection: TextDirection.ltr,
               // child:
               Row(
                 // textDirection: TextDirection.rtl, // ← هذا هو المفتاح لدعم RTL

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(

                          onboardingData.length,
                              (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: _currentPage == i ? 20 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == i ? Color(0xff764880) : Colors.grey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                            // ),
                      const SizedBox(height: 45),
                      Padding(
                        padding: const EdgeInsets.only(left: 20 , right: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Color(0xff764880),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            onPressed: nextPage,
                            child: Text (_currentPage < onboardingData.length - 1 ? "التالي" :"البدء", style: const TextStyle(fontSize: 20 , color: Colors.white,fontWeight: FontWeight.bold,)),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardItem {
  final String title;
  final String desc;
  final String image;

  OnboardItem({
    required this.title,
    required this.desc,
    required this.image,
  });
}