/**
 * واجهة شاشة "حجوزاتي" لتطبيق خطوة سفر
 * تعرض جميع أنواع الحجوزات: طيران، فنادق، مواصلات، مطاعم، أكواخ
 */

import 'package:flutter/material.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';

class MyBookingsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bookings = [
    {
      'type': 'طيران',
      'icon': Icons.flight_takeoff,
      'title': 'رحلة إلى الرياض',
      'details': 'الخطوط السعودية - 12:30 مساءً',
    },
    {
      'type': 'فندق',
      'icon': Icons.hotel,
      'title': 'فندق رافال كمبينسكي',
      'details': '3 ليالٍ - غرفة مزدوجة',
    },
    {
      'type': 'مواصلات',
      'icon': Icons.directions_car,
      'title': 'سيارة من المطار',
      'details': 'تويوتا كامري - السائق: أحمد',
    },
    {
      'type': 'مطعم',
      'icon': Icons.restaurant,
      'title': 'مطعم حدائق النارنج',
      'details': 'حجز الساعة 8:00 مساءً',
    },
    {
      'type': 'كوخ',
      'icon': Icons.cabin,
      'title': 'كوخ جبلي - أبها',
      'details': 'ليلتين - إطلالة بانورامية',
    },
  ];

  @override
  Widget build(BuildContext context) {var heightApp = MediaQuery.of(context).size.height;
  var widthApp = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff764880),
        title: Text('حجوزاتي', style: TextStyle(color: Colors.white)),
        centerTitle: true,  leading: IconButton(
        onPressed: () {   Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CustomTabBar()), // غيّر NextScreen لشاشتك التالية
        );},
        icon: Icon(Icons.arrow_back_ios_new_outlined , color: Colors.white,),
      ),
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(booking['icon'], color: Color(0xff764880), size: 30),
              title: Text(booking['title'], textAlign: TextAlign.right),
              subtitle: Text(booking['details'], textAlign: TextAlign.right),
              trailing: Text(
                booking['type'],
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
          );
        },
      ),
    );
  }
}
