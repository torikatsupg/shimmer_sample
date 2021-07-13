import 'package:flutter/material.dart';

class Shimmer extends StatelessWidget {
  const Shimmer({required this.child, Key? key}) : super(key: key);

  final Widget child;

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
            Colors.black,
            Colors.white,
          ],
          stops: [
            0.5,
            0.51,
          ],
        );
        return gradient.createShader(shimmerRect);
      },
      child: child,
    );
  }
}
