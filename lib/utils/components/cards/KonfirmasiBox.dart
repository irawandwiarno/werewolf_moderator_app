import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';

class Konfirmasibox extends StatelessWidget {
  Konfirmasibox(
      {required this.onPressed, required this.title, this.buttonTitle, this.buttonColor})
      : super();

  VoidCallback onPressed;
  String title;
  String? buttonTitle;
  Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: MyText.title(),
        ),
        // SizedBox(height: 10),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor ?? Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            buttonTitle ?? "Konfirmasi",
            style: MyText.title(color: MyColors.defaultWhite),
          ),
        ),
      ],
    );
  }
}
