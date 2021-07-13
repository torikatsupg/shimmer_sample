import 'package:flutter/material.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({required this.child, Key? key}) : super(key: key);

  final Widget child;
  @override
  _ShimmerState createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // controllerを初期化する
    _controller = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1500))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // controllerをdisposeする
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // shimmerのRenderObjectを取得する
    // shimmerが一度もbuildされていない場合はRenderObjectが取得できない
    final shimmerBox = context.findRenderObject() as RenderBox?;
    if (shimmerBox == null) {
      // shimmerのRenderObjectが存在しなければ何もないウィジェットを返す
      return SizedBox();
    }

    // Offset.zeroをRenderObjectの座標系に変換する
    // つまり、RenderObjectのleftとtopを取得する
    final offsetWithinShimmer =
        shimmerBox.localToGlobal(Offset.zero, ancestor: shimmerBox);

    // グラデーションの範囲をShimmerと同じ範囲にする
    final shimmerRect = Rect.fromLTWH(
      offsetWithinShimmer.dx,
      offsetWithinShimmer.dy,
      shimmerBox.size.width,
      shimmerBox.size.height,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        final gradient = LinearGradient(
          colors: [
            Color(0xFFEBEBF4),
            Color(0xFFF4F4F4),
            Color(0xFFEBEBF4),
          ],
          stops: [
            0.1,
            0.3,
            0.4,
          ],
          transform: _SlidingGradientTransform(_controller.value),
          begin: Alignment(-1, -0.3),
          end: Alignment(1, 0.3),
          tileMode: TileMode.clamp,
        );
        return gradient.createShader(shimmerRect);
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform(this.slidePercent);

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
}
