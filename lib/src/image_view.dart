import 'package:banner_swipper/src/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage_2/provider.dart';
import 'package:flutter_advanced_networkimage_2/transition.dart';

class ImageView extends StatelessWidget {
  /// 图片资源路径
  final String src;

  /// 占位符
  final Widget placeholder;

  /// 图片类型
  final ImageSourceType type;

  const ImageView({
    super.key,
    required this.src,
    required this.type,
    this.placeholder = const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      strokeWidth: 2.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return type == ImageSourceType.asset
        ? Image.asset(src, fit: BoxFit.cover)
        : TransitionToImage(
            fit: BoxFit.cover,
            placeholder: placeholder,
            image: AdvancedNetworkImage(
              src,
              timeoutDuration: const Duration(
                seconds: 30,
              ),
              cacheRule: const CacheRule(
                maxAge: Duration(days: 7),
              ),
            ),
          );
  }
}
