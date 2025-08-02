import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_step/view/booking.dart';
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // حالات المفاتيح (ON/OFF)
  bool notificationsEnabled = false;
  bool lightMode = true;
  bool quickLogin = false;
  bool signLanguage = false;

  @override
  Widget build(BuildContext context) {var heightApp = MediaQuery.of(context).size.height;
    var widthApp = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xFFfbfae9),
      appBar: AppBar(
        // backgroundColor: Color(0xFFfbfae9),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 40,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("المزيد", style: TextStyle(color: Color(0xff764880), fontSize: 20)),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    elevation: 0,
                  ),
                  icon:  SvgPicture.asset("assets/images/elements (1).svg"),
                  label: const Text("تسجيل خروج", style: TextStyle(fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                ListTile(
                  tileColor:
                  
                  Color(0xff764880).withOpacity(.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  leading: SvgPicture.asset("assets/images/Icon.svg",color:   Color(0xff764880),),
                  title: const Text("حجوزاتي"),
                  subtitle: const Text("راجع جميع حجوزاتك السابقة والنشطة"),
                  trailing: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white.withOpacity(.4),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_forward , color:   Color(0xff764880),),
                    ),
                  ),
                  onTap: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MyBookingsScreen()));
                  },
                ),
                const SizedBox(height: 24),
                const Text("إعدادات التطبيق", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Color(0xff764880))),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                  decoration: BoxDecoration(color: Color(0xff764880).withOpacity(.3), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("اللغات", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          languageOption("English", "🇺🇸", false),
                          languageOption("العربية", "🇸🇦", true),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                settingToggle("تفعيل الإشعارات", Icons.notifications_none_rounded, notificationsEnabled, (val) {
                  setState(() => notificationsEnabled = val);
                }),
                const SizedBox(height: 24),
                const Text("تسهيلات الاستخدام", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ,color: Color(0xff764880))),
                const SizedBox(height: 15),
                settingToggle("نمط لايت", Icons.light_mode_outlined, lightMode, (val) {
                  setState(() => lightMode = val);
                }),
                const SizedBox(height: 10),
                settingTile("تغيير حجم الخط", Icons.text_fields_rounded),
                const SizedBox(height: 10),
                settingToggle("تسجيل الدخول السريع", Icons.fingerprint, quickLogin, (val) {
                  setState(() => quickLogin = val);
                }),

                const SizedBox(height: 30),
                settingTile("عن البرنامج", Icons.info_outline), const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget languageOption(String label, String flag, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFfbfae9),
      ),
      child: Row(
        children: [
          Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ?   Color(0xff764880) : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(flag),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget settingToggle(String title, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        color: Color(0xff764880).withOpacity(.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        activeColor:   Color(0xff764880),
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.black12,
        title: Text(title),
        secondary: Icon(icon, color: Color(0xff764880)),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget settingTile(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        color:Color(0xff764880).withOpacity(.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(title),
        leading: Icon(icon , color:  Color(0xff764880),),
        onTap: () {},
      ),
    );
  }
}
