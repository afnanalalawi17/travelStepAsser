import 'package:flutter/material.dart';
import 'package:travel_step/view/bottom_nav_bar.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String selectedFilter = 'الكل';

  final List<Map<String, dynamic>> transactions = [
    {'type': 'إيداع نقدي', 'amount': 2500, 'date': '15 يناير 2025', 'time': '10:30 ص', 'status': 'مكتمل'},
    {'type': 'سحب نقدي', 'amount': -1200, 'date': '14 يناير 2025', 'time': '03:45 م', 'status': 'مكتمل'},
    {'type': ' حجز فندق', 'amount': -5000, 'date': '13 يناير 2025', 'time': '11:15 ص', 'status': 'مكتمل'},
    {'type': 'إيداع نقدي', 'amount': 3200, 'date': '12 يناير 2025', 'time': '02:10 م', 'status': 'مكتمل'},
    {'type': 'حجز مطعم', 'amount': -2750, 'date': '10 يناير 2025', 'time': '04:30 م', 'status': 'مكتمل'},
    {'type': 'مشتريات متنوعة', 'amount': -450, 'date': '30 ديسمبر 2024', 'time': '07:45 ص', 'status': 'مكتمل'},
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    if (selectedFilter == 'الكل') return transactions;
    if (selectedFilter == 'إيداع') {
      return transactions.where((e) => e['amount'] > 0).toList();
    } else {
      return transactions.where((e) => e['amount'] < 0).toList();
    }
  }
  int balance = 0; // معرف مسبقاً في أعلى الـState

  @override
  Widget build(BuildContext context) {var heightApp = MediaQuery.of(context).size.height;
  var widthApp = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: const Color(0xfff9f9f9),
 appBar: AppBar(
        backgroundColor:Color(0xff764880),
    title:  Text("المحفظة الرقمية", style: TextStyle( color: Colors.white,),),
    elevation: 0,
    centerTitle: true,
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

          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xff764880), Color(0xff764880)],
              ),
            ),
            child: Column(
              children: [
                const Text("إجمالي الرصيد", style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                Text(balance == 0 ?  "8,750 ريال" : "$balance ريال ",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text("آخر تحديث: اليوم 02:30 م",
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          // فلترة
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('المعاملات', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    FilterChip(
                      label: const Text('الكل'),
                      selected: selectedFilter == 'الكل',
                      onSelected: (_) => setState(() => selectedFilter = 'الكل'),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('إيداع'),
                      selected: selectedFilter == 'إيداع',
                      onSelected: (_) => setState(() => selectedFilter = 'إيداع'),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('سحب'),
                      selected: selectedFilter == 'سحب',
                      onSelected: (_) => setState(() => selectedFilter = 'سحب'),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final t = filteredTransactions[index];
                final isDeposit = t['amount'] > 0;
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isDeposit ? Colors.green.shade50 : Colors.red.shade50,
                      child: Icon(isDeposit ? Icons.arrow_downward : Icons.arrow_upward,
                          color: isDeposit ? Colors.green : Colors.red),
                    ),
                    title: Text(
                      '${isDeposit ? '+' : ''}${t['amount'].abs()} ريال',
                      style: TextStyle(color: isDeposit ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${t['type']}\n${t['date']} • ${t['time']}'),
                    trailing: const Text('مكتمل', style: TextStyle(color: Colors.grey)),
                  ),
                );
              },
            ),
          ),

          // إحصائيات سريعة
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: const [
                        Text('إجمالي السحوبات'),
                        SizedBox(height: 8),
                        Text('9,450 ريال', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: const [
                        Text('إجمالي الإيداعات'),
                        SizedBox(height: 8),
                        Text('18,200 ريال', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // زر إضافة رصيد
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,

                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    TextEditingController _amountController = TextEditingController();

                    return Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 20, // ⬅️ يحسب ارتفاع الكيبورد
                        top: 20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "إضافة رصيد",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              hintText: "أدخل المبلغ",
                              filled: true,
                              fillColor: Color(0xfff5f5f5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff764880),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                            ),
                            onPressed: () {
                              if (_amountController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("يرجى إدخال المبلغ")),
                                );
                                return;
                              }

                              setState(() {
                                balance += int.parse(_amountController.text); // إذا كان لديك متغير رصيد
                              });

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "تمت إضافة ${_amountController.text} ريال بنجاح"),
                                ),
                              );
                              // FocusScope.of(context).unfocus();

                              // TODO: add backend logic here
                            },
                            child: Text("تأكيد الإيداع",
                                style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff764880),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('إضافة رصيد', style: TextStyle(fontSize: 16 , color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}