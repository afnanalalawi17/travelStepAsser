
import 'package:get/get.dart';
import 'package:travel_step/view/tab_item.dart';

class BottomNavBarController extends GetxController {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
    List<TabItem> tabItemsList = [
     TabItem(
        stateMachine: "assets/images/Icon (1).svg",
        artboard: "الرئيسية"),
    // TabItem(stateMachine: "assets/images/profile_bottom_nav_bar_un.svg", artboard: "CHAT"),
    TabItem(
        stateMachine: "assets/images/notification-01.svg",
        artboard: "الإشعارات"),
   TabItem(
        stateMachine: "assets/images/Icon (2).svg",
        artboard: "المزيد"),
    // TabItem(stateMachine: "assets/images/home_bottom_nav_bar_un.svg", artboard: "TIMER"),

    // TabItem(stateMachine: "assets/images/calendar_bottom_nav_bar_un.svg", artboard: "USER"),
  ];

  int selectedTab = 0;

  void onTabPress(int index) {
    if (selectedTab != index) {
    
        selectedTab = index;
    update();
      // widget.onTabChange(index);

      // _icons[index].status!.change(true);
      Future.delayed(const Duration(seconds: 1), () {
        // _icons[index].status!.change(false);
      });
    }
  }
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
//  loginStat.changeLoginState('Login');
 update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}