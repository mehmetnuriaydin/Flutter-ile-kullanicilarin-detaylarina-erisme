import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class egitimDataView extends StatefulWidget {
  const egitimDataView({super.key});

  @override
  State<egitimDataView> createState() => _egitimDataViewState();
}

class _egitimDataViewState extends State<egitimDataView> {
  Map<String, double> dataMap = Map();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').where('category', isEqualTo: 'Eğitim').get();

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
        title: Text('Eğitim Kategorisi Kişi Sayısı'),
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
