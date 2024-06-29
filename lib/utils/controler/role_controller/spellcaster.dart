import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Spellcaster extends BaseRole {
  Spellcaster()
      : super(
      dataCard: new DataCard(
          id: RoleId.spellcaser,
          roleName: "Spellcaster",
          description: "memilih pemain di malam hari untuk di bisukan saat pagi tiba",
          image: "assets/image/role/spellcaster.jpg"),
      defaultPerintah: "Pilih pemain untuk di bisukan");

  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void chooseAction(int indexChoosedCard) {
    var otherObject = gameManagement.dataPlayer[indexChoosedCard];
    gameManagement.displayPromt.add(Konfirmasibox(onPressed: (){
      otherObject.silentSet(true);
      gameManagement.nextPlayer();
    }, title: "Yakin ingin membisukan?"));
    otherObject.chooseSet(true);
    super.chooseAction(indexChoosedCard);
  }
}
