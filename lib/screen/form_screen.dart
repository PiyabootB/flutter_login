import 'package:flutter/material.dart';
import 'package:flutter_login/model/Transactions.dart';
import 'package:flutter_login/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();

  // Controller
  final titleController = TextEditingController(); // รับค่าชื่อรายการ
  final amountController = TextEditingController(); // รับค่าจำนวนเงิน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แบบฟอร์ม"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(
              10.0), // กำหนดระยะห่างของ Widget ออกจาก ขอบใน ของ Layout
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // กำหนดตำแหน่งแสดงผล start = ชิดซ้าย
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                  autofocus: true,
                  controller: titleController,
                  validator: (String str) {
                    // กรณีชื่อรายการเป็นค่าว่าง
                    if (str.isEmpty) {
                      return "กรุณาป้อนชื่อรายการ";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "จำนวนเงิน"),
                  controller: amountController,
                  keyboardType: TextInputType
                      .number, // กำหนดคีย์บอร์ดให้เป็นตัวเลขเท่านั้น
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "กรุณาป้อนจำนวนเงิน";
                    }
                    // แปลงค่าตัวเลข
                    if (double.parse(str) <= 0) {
                      return "กรุณาป้อนจำนวนมากกว่า 0";
                    }
                    return null;
                  },
                ),
                FlatButton(
                  child: Text("เพิ่มข้อมูล"),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    if (formkey.currentState.validate()) {
                      var title = titleController.text;
                      var amount = amountController.text;

                      //print(title);
                      //print(amount);

                      // เตรียมข้อมูล Provider
                      Transactions statement = Transactions(
                          title: title,
                          amount: double.parse(amount),
                          date: DateTime.now()); //object

                      //เรียก Provider
                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.addTransaction(statement);
                      Navigator.pop(context); // เมื่อกดปุ่ม ให้ปิดหน้าต่างแล้วกลับไปหน้าแอพ
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
