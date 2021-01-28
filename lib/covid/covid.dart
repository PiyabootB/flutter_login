import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ListBox.dart';
import 'CovidStatus.dart';

class CovidPages extends StatefulWidget {
  @override
  _CovidPagesState createState() => _CovidPagesState();
}

class _CovidPagesState extends State<CovidPages> {
  CovidStatus _dataFromAPI;
  @override
  void initState() {
    super.initState();
    getCovidStatus();
  }

  Future<CovidStatus> getCovidStatus() async {
    var url = "https://covid19.th-stat.com/api/open/today";
    var response = await http.get(url);

    _dataFromAPI = covidStatusFromJson(response.body); // json => dart object
    print(_dataFromAPI);
    return _dataFromAPI;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สถานการณ์โควิด-19",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: FutureBuilder(
          future: getCovidStatus(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListBox(
                        "ติดเชื้อสะสม",
                        result.confirmed,
                        Colors.yellow[800],
                        100,
                        "เพิ่มขึ้น " + result.newConfirmed.toString()),
                    SizedBox(
                      height: 5,
                    ),
                    ListBox("หายแล้ว", result.recovered, Colors.green, 100,
                        "เพิ่มขึ้น " + result.newRecovered.toString()),
                    SizedBox(
                      height: 5,
                    ),
                    ListBox("รักษาอยู่ใน รพ.", result.hospitalized, Colors.red,
                        100, "เพิ่มขึ้น " + result.newHospitalized.toString()),
                    SizedBox(
                      height: 5,
                    ),
                    ListBox("เสียชีวิต", result.deaths, Colors.black, 100,
                        "เพิ่มขึ้น " + result.newDeaths.toString()),
                    SizedBox(
                      height: 5,
                    ),
                    Text("อัพเดทข้อมูล ณ " + result.updateDate),
                  ],
                ),
              );
            }
            return LinearProgressIndicator();
          },
        ));
  }
}
