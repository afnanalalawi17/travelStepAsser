import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart'
    as carousel_slider; // Alias the carousel_slider import
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:travel_step/view/map.dart';
import 'package:travel_step/view/naroAI.dart';
import 'package:travel_step/view/reservation.dart';
import 'package:travel_step/view/travelPlanner.dart';
import 'package:travel_step/view/wallet.dart' show TransactionsScreen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey _carouselKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _bookingsKey = GlobalKey();
  final GlobalKey _aiGuideKey = GlobalKey();
  final GlobalKey _calendarKey = GlobalKey();
  final GlobalKey _mapKey = GlobalKey();
  final GlobalKey _walletKey = GlobalKey();

  final List<String> imagePaths = [
    'assets/images/imag1.jpeg',
    'assets/images/imag2.jpg',
    'assets/images/imag3.jpg',
    'assets/images/imag4.jpg',
    'assets/images/imag5.jpg',
  ];
  final services = [
    {
      'icon': "assets/images/AI.png",
      'title': 'المرشد الذكي',
      'desc': 'تفاعل واستفسر صوتياً و نصياً',
    },
    {
      'icon': "assets/images/cleander.png",
      'title': 'الجدول السياحي',
      'desc': 'جدول مخصص حسب تفضيلاتك',
    },
    {
      'icon': "assets/images/map.png",
      'title': 'الخريطة التفاعلية',
      'desc': 'استكشف نقاط المهمة بسهولة',
    },
    {
      'icon': "assets/images/wallet.png",
      'title': 'المحفظة السياحية',
      'desc': 'تابع نفقات رحلتك بخطوة بخطوة',
    },
  ];
  BuildContext? myContext;
  final _controller = carousel_slider.CarouselController();
  int _currentcarousel = 0;
  @override
  void initState() {
    super.initState();
    _checkAndShowShowcase();
  }

  void _checkAndShowShowcase() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShown = prefs.getBool('hasShownShowcase') ?? false;

    if (!hasShown) {
      // Wait until the widget is built
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted && myContext != null) {
          ShowCaseWidget.of(myContext!).startShowCase([
            _carouselKey,
            _servicesKey,
            _bookingsKey,
            _aiGuideKey,
            _calendarKey,
            _mapKey,
            _walletKey,
          ]);

          // Save that it has been shown
          prefs.setBool('hasShownShowcase', true);
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final keys = [_aiGuideKey, _calendarKey, _mapKey, _walletKey];

    var heightApp = MediaQuery
        .of(context)
        .size
        .height;
    var widthApp = MediaQuery
        .of(context)
        .size
        .width;
    return ShowCaseWidget(builder: Builder(builder: (context) {
      myContext = context;
      return Scaffold(
        // backgroundColor: Color(0xFFfbfae9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff764880), width: 2),
                ),
                child: CircleAvatar(
                  backgroundColor: Color(0xFFfbfae9),
                  child: Text("AB", style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "صباح الخير أفنان أحمد العلاوي ",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'IBMPlexSansArabic',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: badges.Badge(
                badgeContent: Text(
                  '3',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                position: badges.BadgePosition.topStart(top: -10, start: -5),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.red,
                  padding: EdgeInsets.all(6),
                  shape: badges.BadgeShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/images/notification-01.svg",
                  height: 24,
                  color: Color(0xff764880),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset(
                "assets/images/translate.svg",
                color: Color(0xff764880),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30),
                Showcase(
                    key: _carouselKey,
                    title: "الصور",
                    description: "هنا يمكنك تصفح أجمل الوجهات السياحية",
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        enlargeCenterPage: true,
                        // Center image enlarged
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        viewportFraction: 0.75,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentcarousel = index;
                          });
                        }, // Controls how much of side images are shown
                      ),
                      items:
                      imagePaths.map((imagePath) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    )),
                const SizedBox(height: 12),

                // Dots Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  imagePaths
                      .asMap()
                      .entries
                      .map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: _currentcarousel == entry.key ? 16.0 : 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4),
                          color:
                          _currentcarousel == entry.key
                              ? Color(0xff764880)
                              : Colors.grey.shade400,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: const Text(
                    "الخدمات",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff764880),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
            Showcase(
              key: _servicesKey,
              title: "الخدمات",
              description: " المحفظة السياحية :تابع نفقات رحلتك بخطوة بخطوة الخريطة التفاعلية : استكشف نقاط المهمة بسهولة  \n الجدول السياحي :جدول مخصص حسب تفضيلاتك \n المرشد الذكي :تفاعل واستفسر صوتياً و نصياً  \n",
              child:  Padding(
                    padding: const EdgeInsets.only(right: 22, left: 22),
                    child: GridView.builder(shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      itemCount: services.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 5 / 4,
                      ),
                      itemBuilder: (context, index) {
                        final item = services[index];

                        return
                          // Showcase(
                          // key: keys[index],
                          // title: item['title'],
                          // description: item['desc'],
                          // // ← الوصف تحت العنوان
                          // targetShapeBorder: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(12)),
                          // child:
                          GestureDetector(onTap: () {
                            if (index == 0) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => TravelStepAIScreen()));
                            }
                            if (index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => TravelPlannerAI()));
                            }
                            if (index == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => InteractiveMapScreen()));
                            }
                            if (index == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => TransactionsScreen()));
                            }
                          },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 2, color: Color(0xff764880)),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      item["icon"] as String, width: 100,
                                      height: 50),
                                  SizedBox(height: 12),
                                  Text(
                                    item['title'] as String,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff764880),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );}))),

                    // })),
       // );
       //                },
       //              )
       //          ),

                SizedBox(height: 24),

                // Bottom button
                Showcase(
                    key: _bookingsKey,
                    title: "الحجوزات",
                    description: "اضغط هنا للدخول إلى نظام الحجوزات الموحد",
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff764880),
                            padding: const EdgeInsets.symmetric(vertical: 11),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => servicesView()));
                          },
                          child: Text(
                              "نظام حجوزات موحد", style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,)),
                        ),
                      ),
                    )),

                SizedBox(height: 24),


              ],
            ),
          ),
        ),

      );
    }));
  }
}
