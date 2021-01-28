import 'package:flutter/material.dart';
import 'package:flutter_login/main.dart';
import 'package:flutter_login/model/Transactions.dart';
import 'package:flutter_login/provider/transaction_provider.dart';
import 'package:flutter_login/ui/app/app_drawer.dart';
import 'package:flutter_login/screen/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/*
void main() {
  runApp(MyApp());
}
*/

class Finance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: "Finance System",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: MyHomepage(title: "แสดงข้อมูล"),
      ),
    );
  }
}

class MyHomepage extends StatefulWidget {
  MyHomepage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormScreen();
                  }));
                })
          ],
        ),
        body: Consumer(
            builder: (context, TransactionProvider provider, Widget child) {
          var count = provider.transactions.length; //นับจำนวนข้อมูล
          if (count <= 0) {
            return Center(
              child: Text(
                "ไม่พบข้อมูล",
                style: TextStyle(fontSize: 35),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: count,
                itemBuilder: (context, int index) {
                  Transactions data = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(data.amount.toString()),
                        ),
                      ),
                      title: Text(data.title),
                   //   subtitle: Text(data.date.toString()),   // ไม่ได้กำหนดรูปแบบวัน-เวลา
                      subtitle: Text(DateFormat("dd/MM/yyyy - HH:mm:ss").format(data.date)),   // กำหนดรูปแบบการแสดงผล
                    ),
                  );
                });
          }
        }));
  }
}
