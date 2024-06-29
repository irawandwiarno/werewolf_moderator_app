import 'package:ww_moderator/exports.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/cards/choose_box.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Witch extends BaseRole {
  Witch()
      : super(
            dataCard: new DataCard(
                id: RoleId.witch,
                roleName: "Witch",
                description: "Kill Or Save player",
                image: "assets/image/role/witch.jpg"),
            defaultPerintah:
                "Pilih satu palyer untuk di bunuh atau di lindungi");

  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void chooseAction(int indexChoosedCard) {
    var otherObject = gameManagement.dataPlayer[indexChoosedCard];

    gameManagement.displayPromt.add(ChooseBox(
        onPressedLeft: () {
          otherObject.kill(this);
          gameManagement.displayPromt.clear();
          gameManagement.nextPlayer();
        },
        onPressedRight: () {
          otherObject.protect();
          gameManagement.displayPromt.clear();
          gameManagement.nextPlayer();
        },
        buttonTitleLeft: "Bunuh",
        buttonTitleRight: "lindungi",
        title: "Mau melindungi apa membunuh?"));
    super.chooseAction(indexChoosedCard);
  }
}
