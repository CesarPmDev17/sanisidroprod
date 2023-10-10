part of 'widgets.dart';

class Skeleton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool fluid;

  const Skeleton(
      {this.width = 100.0,
      this.height = 20.0,
      this.borderRadius = 8.0,
      this.fluid = false});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: BorderRadius.circular(10.0),
      gradientColor: Colors.white.withOpacity(.10),
      shimmerColor: Colors.white.withOpacity(.23),
      shimmerDuration: 1000,
      child: Container(
        width: this.fluid ? double.infinity : this.width,
        height: this.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(this.borderRadius),
            color: akGreyColor.withOpacity(0.45)),
      ),
    );
  }
}
