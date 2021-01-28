import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// สร้าง container ต้นแบบเอาไว้
// ignore: must_be_immutable
class BoxDesign extends StatelessWidget {

   String title; //ชื่อ
   int amount; //จำนวน
   Color color; //สีของกล่อง
   double size; //ขนาดของกล่อง
   String more; //จำนวนที่เพิ่มขึ้น

  BoxDesign(this.title, this.amount, this.color, this.size, this.more);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      height: size,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            child: Image.asset('images/medi.png'),
          ),
          Text(
            ' '+title,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListTile(
              title: Text(
                '${NumberFormat("#,###.##").format(amount)}',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              subtitle: Text(
                more,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
