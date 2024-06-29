import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';

class ChooseBox extends StatelessWidget {
  ChooseBox({
    required this.onPressedLeft,
    required this.onPressedRight,
    required this.title,
    this.buttonTitleLeft,
    this.buttonTitleRight,
    this.buttonColorLeft,
    this.buttonColorRight,
  }) : super();

  VoidCallback onPressedLeft;
  VoidCallback onPressedRight;
  String title;
  String? buttonTitleLeft;
  String? buttonTitleRight;
  Color? buttonColorLeft;
  Color? buttonColorRight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: MyText.subtitle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onPressedLeft,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColorLeft ?? MyColors.redDead,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                buttonTitleLeft ?? "No",
                style: MyText.title(color: MyColors.defaultWhite),
              ),
            ),
            SizedBox(width: 20,),
            ElevatedButton(
              onPressed: onPressedRight,
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColorRight ?? MyColors.varianBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                buttonTitleRight ?? "Yes",
                style: MyText.title(color: MyColors.defaultWhite),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
