import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'apicv.dart';
import 'box.dart';

class CovidPage extends StatefulWidget {
    
  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  ApiCv dataApi;
  
  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  Future<ApiCv> getExchangeRate() async {
    var url = "https://covid19.th-stat.com/api/open/today";
    var response = await http.get(url);
    dataApi = apiCvFromJson(response.body);
    print(dataApi);
    return dataApi;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fetch Data From Api',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Fetch Data API'),
            ),
            body: FutureBuilder(
                future: getExchangeRate(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var result = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          BoxDesign("ติดเชื้อสะสม", result.confirmed, Colors.pink, 100,'เพิ่มขึ้น '+result.newConfirmed.toString()),
                          SizedBox(height: 5,),
                          BoxDesign("หายแล้ว", result.recovered, Colors.green, 100,'เพิ่มขึ้น '+result.newRecovered.toString()),
                          SizedBox(height: 5,),
                          BoxDesign("รักษาอยู่ใน รพ.", result.hospitalized, Colors.blue, 100,'เพิ่มขึ้น '+result.newHospitalized.toString()),
                          SizedBox(height: 5,),
                          BoxDesign("เสียชีวิต", result.deaths, Colors.red, 100,'เพิ่มขึ้น '+result.newDeaths.toString()),
                          SizedBox(height: 5,),
                          Text('update@ '+result.updateDate+' from '),
                        ],
                      ),
                    );
                  }
                  return LinearProgressIndicator();
                })));
  }
}
