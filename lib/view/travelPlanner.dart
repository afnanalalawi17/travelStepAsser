/**
 * تطبيق خطوة سفر - إنشاء جدول سياحي وحفظه وعرضه PDF
 */

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';


class TravelPlannerAI extends StatefulWidget {
  @override
  _TravelPlannerAIState createState() => _TravelPlannerAIState();
}

class _TravelPlannerAIState extends State<TravelPlannerAI> {
  final _formKey = GlobalKey<FormState>();
  String duration = '', people = '', budget = '', tripType = '', transport = '', activities = '';
  String timing = '', customOptions = '', mood = '';
  late pw.Document pdfDocument;

  @override
  Widget build(BuildContext context) {var heightApp = MediaQuery.of(context).size.height;
  var widthApp = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color(0xFFfbfae9),
      appBar: AppBar(  centerTitle: true, // ✅ هذا يجعل العنوان في المنتصف فعليًا

        backgroundColor:Color(0xff764880),
        title: Text("خطة الرحلة", style: TextStyle( color: Colors.white,),),
        elevation: 0,
        leading: IconButton(
          onPressed: () {   Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomTabBar()), // غيّر NextScreen لشاشتك التالية
          );},
          icon: Icon(Icons.arrow_back_ios_new_outlined , color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("أنشئ جدولك السياحي بالذكاء الاصطناعي", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                DropDownTwoSearchField<String>(
                  hint: "مدة الرحلة" ,
                  items: ["يوم واحد", "3 أيام", "أسبوع", "أسبوعين"],
                  itemAsString: (item) => item,
                  compareFn: (item1, item2) => item1 == item2,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        duration = val;
                      });
                    }
                  },

                ),  SizedBox(height: 16),
                DropDownTwoSearchField<String>(
                  hint:"عدد الأشخاص" ,
                  items: ["1", "2", "3", "4+", "عائلة كبيرة"],
                  itemAsString: (item) => item,
                  compareFn: (item1, item2) => item1 == item2,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        people = val;
                      });
                    }
                  },

                ),  SizedBox(height: 16),
                DropDownTwoSearchField<String>(
                  hint:"الميزانية" ,
                  items: ["منخفضة", "متوسطة", "مرتفعة", "فاخرة"],
                  itemAsString: (item) => item,
                  compareFn: (item1, item2) => item1 == item2,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        budget = val;
                      });
                    }
                  },

                ),  SizedBox(height: 16),
                DropDownTwoSearchField<String>(
                  hint:"نوع الرحلة" ,
                  items: ["استرخاء", "مغامرة", "ثقافية", "عائلية", "رومانسية"],
                  itemAsString: (item) => item,
                  compareFn: (item1, item2) => item1 == item2,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        tripType = val;
                      });
                    }
                  },

                ),  SizedBox(height: 16),
                DropDownTwoSearchField<String>(
                  hint:"تفصيل الأنشطة" ,
                  items: ["مشاهدة معالم", "تسوق", "مغامرات", "أنشطة مائية", "رحلات جبلية"],
                  itemAsString: (item) => item,
                  compareFn: (item1, item2) => item1 == item2,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        activities = val;
                      });
                    }
                  },

                ),  SizedBox(height: 16),
                DropDownTwoSearchField<String>(
                  hint:"وسيلة النقل المفضلة",
                  items: ["سيارة", "باص", "قطار", "طيران داخلي", "دراجة"],
                  itemAsString: (item) => item,
                  compareFn: (item1, item2) => item1 == item2,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        transport = val;
                      });
                    }
                  },

                ),
                SizedBox(height: 16),
                buildTextField("تفضيلات الجدول الزمني", "مثلاً: صباح/مساء، سريع/مرن...", (val) => timing = val),
                buildTextField("خيارات خاصة", "مثلاً: أطفال، كبار سن، ذوي احتياجات...", (val) => customOptions = val),
                buildTextField("المزاج العام للرحلة", "استكشافي، فاخر، رومانسي...", (val) => mood = val),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _generatePDF(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff764880),
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text("ابدأ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (pdfDocument != null) {
                          await Printing.layoutPdf(onLayout: (format) async => pdfDocument.save());
                        }
                      },
                      icon: Icon(Icons.picture_as_pdf, color: Colors.white ,),
                      label: Text("عرض الملف", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff764880),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ],
                ), SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, List<String> options, Function(String?)? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        hint: Text(label),
        validator: (value) => value == null ? 'يرجى اختيار $label' : null,
      ),
    );
  }

  Widget buildTextField(String label, String hint, Function(String) onSaved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(height: 8),
          TextFormField(
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onSaved: (value) => onSaved(value ?? ''),
          )
        ],
      ),
    );
  }

  Future<void> _generatePDF(BuildContext context) async {
    _formKey.currentState?.save();

    final pdf = pw.Document();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("جدولك السياحي - $today", style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text("مدة الرحلة: $duration"),
            pw.Text("عدد الأشخاص: $people"),
            pw.Text("الميزانية: $budget"),
            pw.Text("نوع الرحلة: $tripType"),
            pw.Text("تفصيل الأنشطة: $activities"),
            pw.Text("وسيلة النقل: $transport"),
            pw.Text("الجدول الزمني: $timing"),
            pw.Text("خيارات خاصة: $customOptions"),
            pw.Text("مزاج الرحلة: $mood"),
          ],
        ),
      ),
    );

    setState(() {
      pdfDocument = pdf;
    });
  }
}

class DropDownTwoSearchField<T> extends StatelessWidget {
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final bool Function(T, T)? compareFn;
  final String Function(T)? itemAsString;
  final bool? enabled;
  final String ?hint ;

  const DropDownTwoSearchField({
    super.key,
    required this.items,
    required this.onChanged,
    required this.compareFn,
    this.itemAsString,
    this.enabled,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      onChanged: onChanged,
      compareFn: compareFn,
      enabled: enabled ?? true,
      itemAsString: itemAsString,
      popupProps: PopupProps.menu(
        searchDelay: const Duration(milliseconds: 500),
        containerBuilder: (context, popupWidget) {
          return Container(
            decoration: BoxDecoration(
              // color: AppRepoColors(context).appBackgroundColor,
              // border: Border.all(color: AppRepoColors(context).appBorderColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: popupWidget,
          );
        },
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "البحث ...",
            hintStyle: TextStyle(color: Colors.grey.shade600),
            suffixIcon: Icon(Icons.search, color: Colors.grey.shade600),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            // fillColor: AppRepoColors(context).appWhiteColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade600, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            contentPadding: EdgeInsets.all(16),
          ),
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
        emptyBuilder: (context, searchEntry) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "لا توجد خيارات",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        menuProps: MenuProps(borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            //   // borderSide: BorderSide(
            //   //   color: AppRepoColors(context).appBorderColor,
            //   //   width: 1,
            //   // ),
            // ),
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            filled: true,
            fillColor: Colors.white,
            hintText:hint!,
            // hintStyle: TextStyle(
            //   color: AppRepoColors(context).appLightGreyColor,
            // )
        ),
        // baseStyle: TextStyle(
        //   color: AppRepoColors(context).appPrimaryColor,
        // ),
      ),
      items: items,
    );

  }
}