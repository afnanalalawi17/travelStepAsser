
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_step/constants.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';

class servicesView extends StatefulWidget {
  const servicesView({super.key});

  @override
  State<servicesView> createState() => _servicesViewState();
}

class _servicesViewState extends State<servicesView> {
  List<ServicesModel> servicesList = [
    ServicesModel(
      name:'حجز طيران',
      des: "احجز تذاكر الطيران إلى وجهاتك المفضلة بأسعار منافسة وخيارات متعددة.",
      image: 'assets/images/service1.jpeg',
    ),
    ServicesModel(
        name: 'حجز فندق',
        des: "استعرض واحجز أفضل الفنادق حول العالم بكل سهولة.",
        image: "assets/images/service2.jpg"),
    ServicesModel(
      name: 'فعاليات وأنشطة',
      des:
     "اكتشف فعاليات وأنشطة محلية وعالمية تناسب اهتماماتك",
      image: 'assets/images/service3.jpg',
    ),
    ServicesModel(
        name:'مطاعم',
        des:
       "تصفح أفضل المطاعم واحجز طاولتك بكل سهولة.",
        image: "assets/images/service5.jpeg"),
    ServicesModel(
        name:'كوخ',
        des:
       "احجز كوخًا ريفيًا هادئًا لإقامة مميزة وسط الطبيعة",
        image: "assets/images/service6.jpeg"),
    ServicesModel(
      name: 'تأجير سيارة',
      des:
     "استأجر سيارات بأسعار مناسبة وخيارات متعددة حسب احتياجك",
      image: 'assets/images/مكاتب-تأجير-سيارات-في-جدة.jpg',
    ),
    // ServicesModel(
    //     name: "الاستعلام عن معاملة",
    //     des: "خدمة تمكّن الزوار والموظفين على البحث عن معاملاتهم ومتابعتها.",
    //     image: "assets/images/servicesImages/imageServices7.png"),
  ];
  int? selectedIndex; // Variable to store the selected index

  @override
  Widget build(BuildContext context) {var heightApp = MediaQuery.of(context).size.height;
  var widthApp = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(  centerTitle: true, // ✅ هذا يجعل العنوان في المنتصف فعليًا

        backgroundColor:Color(0xff764880),
        title: Text("الخدمات ", style: TextStyle( color: Colors.white,),),
        elevation: 0,
        leading: IconButton(
          onPressed: () {   Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomTabBar()), // غيّر NextScreen لشاشتك التالية
          );},
          icon: Icon(Icons.arrow_back_ios_new_outlined , color: Colors.white,),
        ),
      ),
      // backgroundColor: const Color(0xff1F2A37),
      body: Padding(
        padding: const EdgeInsets.only(right: 20 , left: 20 , top: 40),
        child: GridView.custom(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0.22, // Vertical spacing
            crossAxisSpacing: 8.0, // Horizontal spacing
            pattern: [
              const WovenGridTile(1),
              const WovenGridTile(
                7 / 9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
                (context, index) => Stack(
              children: [
                GestureDetector(
                  onTap: () {


                    setState(() {
                      selectedIndex =
                          index; // Ensure index is valid and selectedIndex is not null
                    });

                    print(selectedIndex.toString());

                    // Check if selectedIndex is non-null and matches the routes you want


                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        9), // Apply border radius once
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          servicesList[index].image.toString(),
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire space
                          width: double
                              .infinity, // Makes sure the image stretches fully
                          height: double
                              .infinity, // Stretches image height fully as well
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xff000000)
                                    .withOpacity(0.30),
                                const Color(0xff764880),
                              ],
                              stops: [0.30, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, right: 10, left: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Aligns text to the bottom
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align text to the start (left)
                      children: [
                        Text(
                          servicesList[index].name.toString(),
                          style: TextStyle(
                            color: Color(0xffCDDBE6),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: heightApp * 0.01,
                        ), // Add space between texts
                        Text(
                          servicesList[index].des.toString(),
                          style: TextStyle(
                            color: Color(0xffCDDBE6),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: heightApp * 0.01,
                        ), // Add space between texts

                      ],
                    ),
                  ),
                ),
              ],
            ),
            childCount: servicesList
                .length, // Adjust based on your list length
          ),
        ),
      ),




    );
  }
}

class ServicesModel {
  final String? name;
  final String? des;
  final String? image;

  ServicesModel({
    this.name,
    this.des,
    this.image,
  }) {}
}
