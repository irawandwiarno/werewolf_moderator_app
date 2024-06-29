import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class DaySection extends BaseRole {
  DaySection()
      : super(
      dataCard: new DataCard(
          id: RoleId.day,
          roleName: "Day Section",
          description: "Time To Vote",
          image: "assets/image/role/villager.jpg"),
  defaultPerintah: "Voting Time"
  );

  int maxChoose = 1;

  @override
  void callAction(int indexChoosedCard) {
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
    var otherObject = gameManagement.dataPlayer[indexChoosedCard];

    if(gameManagement.voteTime.value){

    }else{
      CommonSnackbar()
          .warning(title: "Belum waktunya Voting", subtitle: "Masih waktu diskusi belum vote");
    }

    super.callAction(indexChoosedCard);
  }

  @override
  void chooseAction(int indexChoosedCard) {
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
    var otherCard = gameManagement.dataPlayer[indexChoosedCard];

    if (listChoosedOfIndex.length < maxChoose &&
        !listChoosedOfIndex.contains(indexChoosedCard)) {


    } else if (listChoosedOfIndex.contains(indexChoosedCard)) {
      listChoosedOfIndex.remove(indexChoosedCard);
      otherCard.isChoose.value = false;
    } else {
      CommonSnackbar()
          .warning(title: "Warning", subtitle: "Kamu sudah memilih");
    }
    super.chooseAction(indexChoosedCard);
  }

  @override
  void kill(BaseRole killer) {
    print('killed v');
    isKill.value = true;
    super.kill(killer);
  }
}
