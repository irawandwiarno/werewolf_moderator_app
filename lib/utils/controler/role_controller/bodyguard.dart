import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/utils/components/cards/choose_box.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Bodyguard extends BaseRole {
  Bodyguard()
      : super(
            dataCard: new DataCard(
                id: RoleId.bodyguard,
                roleName: "Bodyguard",
                description: "Protect Player at night",
                image: "assets/image/role/bodyguard.jpg"),
            defaultPerintah: "Pilih satu orang yang ingin anda lindungi");

  int maxChoose = 1;
  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
  BaseRole? lastProtect;

  @override
  void chooseAction(int indexChoosedCard) {
    var otherCard = gameManagement.dataPlayer[indexChoosedCard];

    if (lastProtect != otherCard) {
      gameManagement.displayPromt.add(Konfirmasibox(
          onPressed: () => protectPlayer(indexChoosedCard: indexChoosedCard),
          title: "Apakah anda yakin ingin melindungi?"));
    } else {
      gameManagement.displayPromt.add(ChooseBox(
          onPressedLeft: () {
            listChoosedOfIndex.remove(indexChoosedCard);
            otherCard.chooseSet(false);
            gameManagement.displayPromt.add(basicAction());
          },
          buttonTitleLeft: "Batal lindungi",
          onPressedRight: () =>
              protectPlayer(indexChoosedCard: indexChoosedCard),
          buttonTitleRight: "Tetap lindungi",
          title: "Player telah di lindungi di malam sebelumnya"));
    }

    otherCard.isChoose.value = true;
    super.chooseAction(indexChoosedCard);
  }

  @override
  void kill(BaseRole killer) {
    if (canKill()) {
      isKill.value = true;
    }
    super.kill(killer);
  }

  void protectPlayer({required int indexChoosedCard}) {
    var otherCard = gameManagement.dataPlayer[indexChoosedCard];
    otherCard.protect();
    lastProtect = otherCard;
    gameManagement.displayPromt.clear();
    gameManagement.nextPlayer();
  }
}
