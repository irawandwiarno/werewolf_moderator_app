import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/drunk.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Seer extends BaseRole {
  Seer()
      : super(
            dataCard: new DataCard(
                id: RoleId.seer,
                roleName: "Seer",
                description:
                    "Memilih seseorang untuk mengetahui apakah dia WW atau bukan",
                image: "assets/image/role/seer.jpg"),
            defaultPerintah:
                "Pilih player untuk di lihat apakah dia villager atau werewolf");

  int maxChoose = 1;
  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void chooseAction(int indexChoosedCard) {
    var otherObject = gameManagement.dataPlayer[indexChoosedCard];
    if (checkRole(otherObject)) {
      gameManagement.displayPromt
          .add(showRole(title: "Yes", indexChoosedCard: indexChoosedCard));
    } else {
      gameManagement.displayPromt
          .add(showRole(title: "No", indexChoosedCard: indexChoosedCard));
    }
    listChoosedOfIndex.add(indexChoosedCard);
    otherObject.chooseSet(true);

    super.chooseAction(indexChoosedCard);
  }

  bool checkRole(BaseRole otherObject){
    if(otherObject.dataCard.id == RoleId.werewolf){
      return true;
    }

    if(otherObject.dataCard.subRole != null){
      otherObject as Drunk;
      if(otherObject.roleAsli.dataCard.id == RoleId.werewolf){
        return true;
      }
    }

    return false;
  }

  Widget showRole({required String title, required int indexChoosedCard}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Tekan untuk menampilkan text"),
          ElevatedButton(
            onPressed: () async {
              await MyDialog().displayText(
                title: title,
                onTap: () => seeRolePlayer(indexChoosedCard: indexChoosedCard),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.varianGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Rounded corners
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 12), // Padding
            ),
            child: Text(
              'Tampilkan',
              style: MyText.title(color: MyColors.defaultWhite),
            ),
          )
        ],
      ),
    );
  }

  void seeRolePlayer({required int indexChoosedCard}) {
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
    gameManagement.displayPromptNext();
    var dataPlayer = gameManagement.dataPlayer[indexChoosedCard];
    dataPlayer.isChoose.value = false;
    gameManagement.nextPlayer();
  }
}
