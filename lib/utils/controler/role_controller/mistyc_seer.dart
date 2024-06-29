import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/base_role.dart';
import 'package:ww_moderator/utils/controler/role_controller/drunk.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class MysticSeer extends BaseRole {
  MysticSeer()
      : super(
            dataCard: new DataCard(
                id: RoleId.mystic_seer,
                roleName: "Mystic Seer",
                description: "Melihat role player lain",
                image: "assets/image/role/mystic_seer.jpg"),
            defaultPerintah: "Pilih player untuk di lihat rolenya");

  int maxChoose = 1;
  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void chooseAction(int indexChoosedCard) {
    var otherObject = gameManagement.dataPlayer[indexChoosedCard];
    var rolePlayer = checkRolePlayer(otherObject);

    gameManagement.displayPromt.add(Konfirmasibox(
      onPressed: () => MyDialog().displayText(
          title: otherObject.dataCard.roleName,
          onTap: () => seeRolePlayer(indexChoosedCard: indexChoosedCard)),
      title: "Tampilkan Nama Role",
      buttonTitle: "Tampilkan",
      buttonColor: MyColors.varianGreen,
    ));
    listChoosedOfIndex.add(indexChoosedCard);
    otherObject.chooseSet(true);
    super.chooseAction(indexChoosedCard);
  }

  String checkRolePlayer(BaseRole otherObject){
    if(otherObject.dataCard.subRole != null){
      return otherObject.dataCard.subRole!;
    }
    return otherObject.dataCard.roleName;

  }

  void seeRolePlayer({required int indexChoosedCard}) {
    gameManagement.displayPromptNext();
    var dataPlayer = gameManagement.dataPlayer[indexChoosedCard];
    dataPlayer.chooseSet(false);
    gameManagement.nextPlayer();
  }
}
