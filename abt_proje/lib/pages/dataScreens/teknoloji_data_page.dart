import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class teknolojiDataView extends StatefulWidget {
  const teknolojiDataView({super.key});

  @override
  State<teknolojiDataView> createState() => _teknolojiDataViewState();
}

class _teknolojiDataViewState extends State<teknolojiDataView> {
  Map<String, double> dataMap = Map();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').where('category', isEqualTo: 'Teknoloji').get();

    List<QueryDocumentSnapshot> users = querySnapshot.docs;

    int erkekSayi = 0;
    int kadinSayi = 0;

    users.forEach((user) {
      if ((user.data() as Map<String, dynamic>?)?['gender'] == 'Erkek') {
        erkekSayi++;
      } else if ((user.data() as Map<String, dynamic>?)?['gender'] == 'Kadın') {
        kadinSayi++;
      }
    });

    setState(() {
      dataMap.putIfAbsent('Erkek', () => erkekSayi.toDouble());
      dataMap.putIfAbsent('Kadın', () => kadinSayi.toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Teknoloji Kategorisi Kişi Sayısı'),
      ),
      body: Center(
        child: (dataMap.length != 0)
            ? PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 2.7,
                colorList: [
                  Colors.blue,
                  Colors.pink,
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                centerText: "Cinsiyet Dağılımı",
                legendOptions: LegendOptions(
                  showLegendsInRow: true,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
