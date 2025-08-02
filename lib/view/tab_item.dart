import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabItem {
  TabItem({
    this.stateMachine = "",
    this.artboard = "",
    // this.status,
  });

  UniqueKey? id = UniqueKey();
  String stateMachine;
  String artboard;
  // late SMIBool? status;

static   List<TabItem> tabItemsList = [
    TabItem(
        stateMachine: "assets/images/order.svg",
        artboard: "الرئيسية"),
    // TabItem(stateMachine: "assets/images/profile_bottom_nav_bar_un.svg", artboard: "CHAT"),
    TabItem(
        stateMachine: "aassets/images/primit.svg",
        artboard: "الخدمات والإجراءات"),
   TabItem(
        stateMachine: "assets/images/trip.svg",
        artboard: "المزيد"),
    // TabItem(stateMachine: "assets/images/home_bottom_nav_bar_un.svg", artboard: "TIMER"),

    // TabItem(stateMachine: "assets/images/calendar_bottom_nav_bar_un.svg", artboard: "USER"),
  ];
}
