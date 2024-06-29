import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Werewolf extends BaseRole {
  Werewolf()
      : super(
            dataCard: new DataCard(
                id: RoleId.werewolf,
                roleName: "Werewolf",
                description: "Bunuh seseorang saat malam",
                image: "assets/image/role/werewolf.jpg"),
  defaultPerintah: "Pilih player untuk di bunuh"
  );

  int maxChoose = 1;
  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void chooseAction(int indexChoosedCard) {
    var otherCard = gameManagement.dataPlayer[indexChoosedCard];
    print('called choose action');

    gameManagement.displayPromt.add(Konfirmasibox(
        onPressed: () => killPlayer(indexChoosedCard),
        title: "Apakah anda yakin ingin membunuh?"));
    otherCard.isChoose.value = true;
    listChoosedOfIndex.add(indexChoosedCard);

    super.chooseAction(indexChoosedCard);
  }

  void killPlayer(int indexChoosedCard) {
    var otherCard = gameManagement.dataPlayer[indexChoosedCard];
    listChoosedOfIndex.clear();
    otherCard.kill(this);
    gameManagement.displayPromt.clear();
    gameManagement.nextPlayer();
  }

  @override
  void kill(BaseRole killer) {
    isKill.value = true;
    super.kill(killer);
  }
}
