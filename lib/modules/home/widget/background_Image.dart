import '../../../exports.dart';

class BackgroundImageWidget extends StatelessWidget {
  final double width;
  final String imagePath;

  const BackgroundImageWidget({
    Key? key,
    required this.width,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
      ),
    );
  }
}
