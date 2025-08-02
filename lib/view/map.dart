/**
 * تطبيق خطوة سفر - إنشاء واجهة خريطة سياحية تفاعلية مع فلترة وعرض معلومات المواقع
 */

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';

void main() => runApp(MaterialApp(home: InteractiveMapScreen()));

class InteractiveMapScreen extends StatefulWidget {
  @override
  _InteractiveMapScreenState createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  String selectedCategory = "الكل";
  late GoogleMapController mapController;

  final List<Map<String, dynamic>> locations = [
    {
      "title": "ممشى المشهد",
      "description": "ممشى آمن ومناسب للعائلات بإطلالة جبلية",
      "image": "assets/images/image1.jpg",
      "lat": 18.2305,
      "lng": 42.5070,
      "category": "أماكن تاريخية",
    },
    {
      "title": "مطعم حدائق النارنج",
      "description": "مطعم عائلي بجلسات خارجية",
      "image": "assets/images/image2.jpg",
      "lat": 18.2200,
      "lng": 42.5050,
      "category": "مطاعم",
    },
    {
      "title": "متحف فاطمة",
      "description": "متحف للتراث الأُسيري",
      "image": "assets/images/image3.jpg",
      "lat": 18.2250,
      "lng": 42.5100,
      "category": "أماكن تاريخية",
    },
    {
      "title": "حديقة سما أبها",
      "description": "فعالية ترفيهية ومغامرات عائلية",
      "image": "assets/images/image4.jpg",
      "lat": 18.2150,
      "lng": 42.5000,
      "category": "فعاليات",
    },
  ];

  @override
  Widget build(BuildContext context) {var heightApp = MediaQuery.of(context).size.height;
  var widthApp = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> filteredLocations = selectedCategory == "الكل"
        ? locations
        : locations.where((loc) => loc['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // ✅ هذا يجعل العنوان في المنتصف فعليًا

        backgroundColor:Color(0xff764880),
        title: Text("الخريطة التفاعلية", style: TextStyle( color: Colors.white,),),
        elevation: 0,
        leading: IconButton(
          onPressed: () {   Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomTabBar()), // غيّر NextScreen لشاشتك التالية
          );},
          icon: Icon(Icons.arrow_back_ios_new_outlined , color: Colors.white,),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => mapController = controller,
            initialCameraPosition: CameraPosition(
              target: LatLng(18.225505698069615, 42.503608728836),
              zoom: 13,
            ),
            markers: filteredLocations.map((loc) => Marker(
              markerId: MarkerId(loc['title']),
              position: LatLng(loc['lat'], loc['lng']),
              infoWindow: InfoWindow(title: loc['title']),
            )).toSet(),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),

          Positioned(
            top: 10,
            right: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      buildCategoryChip("الكل"),
                      buildCategoryChip("مطاعم"),
                      buildCategoryChip("فعاليات"),
                      buildCategoryChip("أماكن تاريخية"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 220,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
              items: filteredLocations.map((loc) {
                return Builder(
                  builder: (context) => GestureDetector(
                    // onTap: () => Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => LocationDetailsPage(location: loc)),
                    // ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 6)
                        ],
                      ),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(

                                topLeft: Radius.circular(15),
                              topRight:  Radius.circular(15),


                            ),
                            child: Image.asset(loc['image'], height: 150, width: double.infinity, fit: BoxFit.fill),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(loc['title'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  // SizedBox(height: 4),
                                  Text(loc['description'], style: TextStyle(fontSize: 12, color: Colors.grey[600]), maxLines: 3, overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryChip(String label) {
    return ChoiceChip(
     checkmarkColor: Colors.white,
      label: Text(label, style: TextStyle(color: selectedCategory == label ? Colors.white : Colors.black)),
      selected: selectedCategory == label,
      selectedColor: Color(0xff764880),
      backgroundColor: Colors.grey.shade200,
      onSelected: (_) => setState(() => selectedCategory = label),
    );
  }
}

class LocationDetailsPage extends StatelessWidget {
  final Map<String, dynamic> location;

  const LocationDetailsPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff764880),
        title: Text(location['title'], style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(location['image'], width: double.infinity, height: 200, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(location['description'], textAlign: TextAlign.right, style: TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(location['lat'], location['lng']),
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(location['title']),
                      position: LatLng(location['lat'], location['lng']),
                    ),
                  },
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
