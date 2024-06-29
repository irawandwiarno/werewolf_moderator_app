import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';

class CardPlayerRole extends StatelessWidget {
  const CardPlayerRole({
    super.key,
    required this.indexOfCard,
  });

  final int indexOfCard;

  @override
  Widget build(BuildContext context) {
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
    var dataPlayer = gameManagement.dataRole[indexOfCard];
    return Obx(() {
      return Container(
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: gameManagement.activeRole.value.dataCard.id == dataPlayer.dataCard.id
                  ? MyColors.varianGreen
                  : MyColors.outline,
              width: 4),
          color: MyColors.primaryColor,
        ),
        height: 130,
        width: 90,
        child: Image.asset(
          dataPlayer.dataCard.image,
          scale: 1,
        ),
      );
    });
  }
}
