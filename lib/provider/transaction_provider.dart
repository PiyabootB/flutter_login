import 'package:flutter/foundation.dart';
import 'package:flutter_login/database/transaction_db.dart';
import 'package:flutter_login/model/Transactions.dart';

class TransactionProvider with ChangeNotifier {
  // ตัวอย่างข้อมูล
/*
  List<Transaction> transactions = [
    Transaction(title: "หมวก", amount: 200, date: DateTime.now())
  ]; */

  List<Transactions> transactions = [];

  //ดึงข้อมูล
  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransaction(Transactions statement) async {
    var db=await TransactionDB(dbName: "transaction.db").openDatabase();
    print(db);
        // transactions.add(statement);    //  เพิ่มค่าใหม่ จะแสดงด้านล่าง
    transactions.insert(0, statement); //  เพิ่มต่าใหม่ แสดงด้านบน
    // แจ้งเตือน Consumer
    notifyListeners();
  }
}
