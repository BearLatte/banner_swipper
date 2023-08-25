import 'dart:async';

import './image_view.dart';
import 'package:flutter/material.dart';

enum ImageSourceType { asset, network }

enum IndicatorAlignment { start, center, end }

class BannerSwipper extends StatefulWidget {
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

  const BannerSwipper(
    this.images, {
    super.key,
    this.scrollDuration,
    this.width = double.infinity,
    this.height = 200.0,
    this.onTap,
    this.curve = Curves.linear,
    this.sourceType = ImageSourceType.network,
    this.indicatorWidth = 10.0,
    this.indicatorHeight = 10.0,
    this.indicatorPadding,
    this.indicatorColor = Colors.white,
    this.indicatorBorderRadius = 5.0,
    this.currentIndicatorColor,
    this.indicatorSpace = 5.0,
    this.alignment = IndicatorAlignment.center,
  }) : assert(images.length != 0);

  @override
  State<BannerSwipper> createState() => _BannerSwipperState();
}

class _BannerSwipperState extends State<BannerSwipper> {
  late List<Widget> _images;
  late int _currentIndex;
  late PageController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 初始化图片，图片的第0项和最后一项分别是
    _images = widget.images
        .map((src) => ImageView(src: src, type: widget.sourceType))
        .toList();

    _currentIndex = _images.length * 10;
    _controller = PageController(initialPage: _currentIndex);
    _initialTimer();
  }

  void _initialTimer() {
    _timer ??= Timer.periodic(
      widget.scrollDuration ?? const Duration(seconds: 5),
      (timer) {
        _currentIndex++;
        _controller.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: widget.curve,
        );
      },
    );
  }

  void _changePage() {
    Timer(const Duration(milliseconds: 500), () {
      _controller.jumpToPage(_currentIndex);
    });
  }

  // 配置一个翻页视图
  Widget _buildPageView() {
    int length = _images.length;
    if (length == 0) return Container();
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: PageView.builder(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              _currentIndex = length;
              _changePage();
            }
          });
        },
        itemBuilder: (context, index) {
          return Listener(
            onPointerDown: (event) => _cancelTimer(),
            onPointerUp: (event) => _initialTimer(),
            child: GestureDetector(
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!(index % _images.length);
                }
              },
              child: _images[index % length],
            ),
          );
        },
      ),
    );
  }

  // 配置 indicator
  Widget _buildIndicator() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          padding: widget.indicatorPadding ?? const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: widget.alignment == IndicatorAlignment.center
                ? MainAxisAlignment.center
                : widget.alignment == IndicatorAlignment.start
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
            children: List.generate(_images.length, (index) {
              return InkWell(
                onTap: () => _scrollTo(index),
                child: Container(
                  margin: EdgeInsets.only(right: widget.indicatorSpace),
                  width: widget.indicatorWidth,
                  height: widget.indicatorHeight,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(widget.indicatorBorderRadius),
                    color: (_currentIndex % _images.length) == index
                        ? (widget.currentIndicatorColor ??
                            Theme.of(context).primaryColor)
                        : widget.indicatorColor,
                  ),
                ),
              );
            }),
          ),
        ));
  }

  void _scrollTo(int page) {
    _cancelTimer();
    setState(() {
      _currentIndex = page;
      _controller.animateToPage(_currentIndex,
          duration: const Duration(milliseconds: 300), curve: widget.curve);
    });
    _initialTimer();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_buildPageView(), _buildIndicator()],
    );
  }
}
