import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/shared/packages.dart';

class MyButtonIcon extends StatelessWidget {
  MyButtonIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size,
    this.height,
    this.color,
  });

  final VoidCallback onPressed;
  final IconData icon;
  double? size;
  double? height;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: color ?? Colors.green,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Sudut membulat
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: MyColors.defaultWhite,
            size: size,
          ),
        ),
      ),
    );
  }
}
