import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';


class TravelStepAIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {var heightApp = MediaQuery.of(context).size.height;
  var widthApp = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(  centerTitle: true, // ✅ هذا يجعل العنوان في المنتصف فعليًا

        backgroundColor:Color(0xff764880),
        title: Text("TravelStep AI", style: TextStyle( color: Colors.white,),),
        elevation: 0,
        leading: IconButton(
          onPressed: () {   Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomTabBar()), // غيّر NextScreen لشاشتك التالية
          );},
          icon: Icon(Icons.arrow_back_ios_new_outlined , color: Colors.white,),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 150),
          Center(
            child: Image.asset(
              "assets/images/Ellipse 7.png",
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 300),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildOption(
                    context,
                    "أين أقرب ممشى آمن؟",
                    "أقرب ممشى هو ممشى المشهد في أبها، يتميز بإطلالة جميلة ومناسب للعائلات."
                ),
                buildOption(
                    context,
                    "رشّح لي مطعم قريب يناسب العائلة",
                    "مطعم حدائق النارنج في أبها مناسب للعائلات ويوفر جلسات خارجية مميزة."
                ),
                buildOption(
                    context,
                    "هل فيه متحف أو معرض قريب؟",
                    "نعم، متحف فاطمة للتراث الأُسيري ومتحف الحضارات في حي المفطة من أفضل الخيارات."
                ),
                buildOption(
                    context,
                    "ما أفضل مطاعم الفطور هنا؟",
                    "مطعم مهنا أو قهوة خطوة في أبها يعتبران من أفضل أماكن الفطور."
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                hintTextDirection: TextDirection.rtl,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    "assets/images/text+ add.png",
                    height: 10,
                    width: 10,
                    fit: BoxFit.fill,
                    color: Color(0xff764880),
                  ),
                ),
                suffixIcon: Icon(
                  Icons.add_circle_outline,
                  color: Color(0xff764880),
                  size: 33,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 50),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0XFFF2F2F2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOption(BuildContext context, String question, String answer) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuggestedAnswerPage(
              question: question,
              answer: answer,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(question, style: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
}

class SuggestedAnswerPage extends StatelessWidget {
  final String question;
  final String answer;

  SuggestedAnswerPage({required this.question, required this.answer});
  LatLng? selectedLatLng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Color(0xff764880),
        title: Center(child: Text("TravelStep AI", style: TextStyle( color: Colors.white,),)),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            print("object");
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CustomTabBar()), // غيّر NextScreen لشاشتك التالية
    );
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined , color: Colors.white,),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150?img=12"),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(question),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text("إليك الإجابة المناسبة لسؤالك"),
                          Text("نأمل أن تساعدك في رحلتك!"),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/Ellipse 7.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:Color(0xff764880).withOpacity(.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(answer, textAlign: TextAlign.right),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GoogleMap(
                          onTap: (LatLng pos) {
                            // setState(() {
                              selectedLatLng = pos;
                            // });
                          },
                          markers: selectedLatLng != null
                              ? {
                            Marker(
                              markerId: MarkerId("selected"),
                              position: selectedLatLng!,
                            ),
                          }
                              : {},

                          initialCameraPosition: CameraPosition(
                            target: LatLng(18.2164, 42.5053), // أبها
                            zoom: 13,
                          ),
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}