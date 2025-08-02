import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';

class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // يبدأ على تبويب "تحديات"
    _tabController = TabController(length: 4, vsync: this, initialIndex: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildNotificationBox({
    required String title,
    required String subtitle,
    required String timeAgo,
    required String imageUrl,
    bool hasActions = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0XFFF2F2F2),
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: Color(0xff764880)),
          const SizedBox(width: 8),
          CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timeAgo,
                  style: const TextStyle(color: Color(0xff764880), fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey[600])),



              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var heightApp = MediaQuery.of(context).size.height;
    var widthApp = MediaQuery.of(context).size.width;
    // final tabStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(  centerTitle: true, // ✅ هذا يجعل العنوان في المنتصف فعليًا

          backgroundColor:Color(0xff764880),
          title: Text("الإشعارات", style: TextStyle( color: Colors.white,),),
          elevation: 0,
          automaticallyImplyLeading: false,

        ),

        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 2, left: 2),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0XFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Set the background color here
                  //  color: Color(0XFF384250).withOpacity(.3), // or any color you prefer
                  child: TabBar(
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: "Rubik",
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 1.0,
                    padding: const EdgeInsets.all(4),
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff764880),
                    ),
                    tabs: [
                      Tab(text: 'الكل'),
                      Tab(text: 'ترشيحات'),
                      Tab(text: 'تنبيهات'),
                      Tab(text: 'عروض'),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  // controller: _tabController,
                  children: [
                    buildTabContent('الكل'),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/Illustration.svg"),
                          SizedBox(height: 12),
                          Text(
                            "ماعندك أي اشعارات حاليًا ",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          SizedBox(height: 12),
                          Text(
                            "ابدأ بحجز  أو انضم لتحدي، و بيوصل لك كل جديد هنا.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    // buildTabContent('حدث'),
                    buildTabContent('تحديات'),
                    buildTabContent('فعاليات'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabContent(String tabName) {
    return ListView(
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "اليوم",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          ),
        ),
        buildNotificationBox(
          title: "مجد رشحت لك وجهة جديدة",
          subtitle: "استكشف موقع ممشى المشهد في أبها",
          timeAgo: "قبل ٣ دقائق",
          imageUrl: "https://i.pravatar.cc/150?img=1",
          hasActions: true,
        ),
        buildNotificationBox(
          title: "تم إضافة فعالية جديدة",
          subtitle: "لا تفوّت زيارة مهرجان صيف أبها",
          timeAgo: "قبل ساعة",
          imageUrl: "https://i.pravatar.cc/150?img=2",
        ),
        buildNotificationBox(
          title: "اقتراح مطعم جديد",
          subtitle: "مطعم حدائق النارنج بإطلالة ساحرة",
          timeAgo: "قبل ساعتين",
          imageUrl: "https://i.pravatar.cc/150?img=3",
        ),
        buildNotificationBox(
          title: "تذكير بالحجز",
          subtitle: "لا تنسَ حجزك في متحف فاطمة اليوم",
          timeAgo: "2025/4/14 - الإثنين",
          imageUrl: "https://i.pravatar.cc/150?img=4",
        ),

        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "هذا الأسبوع",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          ),
        ),
        buildNotificationBox(
          title: "تم إضافة فعالية جديدة",
          subtitle: "لا تفوّت زيارة مهرجان صيف أبها",
          timeAgo: "قبل ساعة",
          imageUrl: "https://i.pravatar.cc/150?img=2",
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
