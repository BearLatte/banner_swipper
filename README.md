# banner_swipper

## Platform Support

| Android | iOS  | MacOS | Web  | Linux | Windows |
| ------- | ---- | ----- | ---- | ----- | ------- |
| ✅       | ✅    | ✅     | ✅    | ✅     | ✅       |



## Usage

```dart
import 'package:banner_swipper/src/index.dart';

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

```

## 属性介绍
```dart
 /// 图片资源路径
  final List<String> images;

  /// 自动轮播间隔
  final Duration? scrollDuration;

  /// 图片类型，本地或网络, 默认为网络图片
  final ImageSourceType sourceType;

  /// 轮播图控件宽度，默认与父容器一样
  final double width;

  /// 轮播图控件高度，默认与父容器一样
  final double height;

  /// 点击回调
  final ValueChanged<int>? onTap;

  /// 翻页方式
  final Curve curve;

  /// 小圆点的宽度
  final double indicatorWidth;

  /// 指示器的高度
  final double indicatorHeight;

  /// 指示器的颜色，默认为白色
  final Color indicatorColor;

  /// 指示器圆角数值
  final double indicatorBorderRadius;

  /// 指示器 padding
  final EdgeInsets? indicatorPadding;

  /// 指示器间隔,默认 5.0
  final double indicatorSpace;

  /// 选中状态下的指示器颜色, 默认为主题颜色
  final Color? currentIndicatorColor;

  /// 指示器基于父视图的对齐方式,默认为居中对齐
  final IndicatorAlignment alignment;
```

## Contact Me

Tim20200212@gmail.com
