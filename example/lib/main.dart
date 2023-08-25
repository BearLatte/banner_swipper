import 'package:flutter/material.dart';
import 'package:banner_swipper/src/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BannerSwipper(
            const [
              'https://cdn1-manfashion.techbang.com/system/excerpt_images/13193/original/9784b0ab3adf7e48cf8119f98e15aa87.jpg?1613716683',
              'https://cdn.sortiraparis.com/images/80/98390/851995-les-gardiens-de-la-galaxie-3.jpg',
              'https://d2eib6r9tuf5y8.cloudfront.net/l/assets/img/article/article-2061-hggqyjvq/keyvisual.jpg',
            ],
            alignment: IndicatorAlignment.end,
            onTap: (index) => debugPrint('DEBUG: 点击了第$index张图片'),
          ),
          BannerSwipper(
            const [
              'asset/images/694711.jpg',
              'asset/images/759351.jpg',
              'asset/images/842583.jpg'
            ],
            sourceType: ImageSourceType.asset,
            indicatorWidth: 15.0,
            indicatorHeight: 2.0,
            indicatorBorderRadius: 1.0,
            indicatorColor: Colors.black54,
            currentIndicatorColor: Colors.blue,
            alignment: IndicatorAlignment.start,
          ),
        ],
      ),
    );
  }
}
