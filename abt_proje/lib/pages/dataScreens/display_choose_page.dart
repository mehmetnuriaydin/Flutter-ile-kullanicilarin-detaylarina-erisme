import 'package:abt_proje/pages/dataScreens/egitim_data_page.dart';
import 'package:abt_proje/pages/dataScreens/saglik_data_page.dart';
import 'package:abt_proje/pages/dataScreens/teknoloji_data_page.dart';
import 'package:abt_proje/pages/dataScreens/tum_data_page.dart';
import 'package:flutter/material.dart';

import '../auth/login_page.dart';

class DisplayChooseView extends StatelessWidget {
  const DisplayChooseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Verilere Göz At'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 170),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              CustomCard(
                  imagePath: 'assets/images/saglik_kategori.jpg',
                  title: 'Sağlık kategorisi kişi sayıları için karta tıklayınız',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => saglikDataView()));
                  }),
              CustomCard(
                  imagePath: 'assets/images/egitim_kategori.jpg',
                  title: 'Eğitim kategorisi kişi sayıları için karta tıklayınız',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => egitimDataView()));
                  }),
              CustomCard(
                  imagePath: 'assets/images/teknoloji_kategori.jpg',
                  title: 'Teknoloji kategorisi kişi sayıları için karta tıklayınız',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => teknolojiDataView()));
                  }),
              CustomCard(
                  imagePath: 'assets/images/tum_kullanicilar.jpg',
                  title: 'Tüm kullanıcı sayıları için tıklayınız',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => tumDataView()));
                  }),
            ],
          ),
        ));
  }
}

class CustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final Function()? onTap;

  const CustomCard({required this.imagePath, required this.title, required this.onTap}) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: <Widget>[
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
