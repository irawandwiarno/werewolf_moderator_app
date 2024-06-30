import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/components.dart';

class BaseRole extends GetxController {
  DataCard dataCard;
  RxBool isDead = false.obs;
  RxBool isProtected = false.obs;
  RxBool isKill = false.obs;
  RxBool isSilent = false.obs;
  RxBool isChoose = false.obs;
  List<int> listChoosedOfIndex = [];
  List<VoidCallback> deadCallbak = [];
  String defaultPerintah;
  int maxChoose = 1;
  RxInt voteCount = 0.obs;
  int? maxUseSkill;


  BaseRole({
    required this.dataCard,
    required this.defaultPerintah,
  }) : super();

  void kill(BaseRole killer) {
    if (canKill()) {
      isKill.value = true;
    }
  }

  void dead(bool value) {
    if (deadCallbak.isNotEmpty) {
      for (var item in deadCallbak) {
        item();
      }
    }
    isDead.value = value;
  }

  void protect() {
    if (isKill.value) {
      isKill.value = false;
    }
    isProtected.value = true;
  }

  void vote() {
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
    dead(true);
    gameManagement.nextPlayer();
  }

  void voteCountChange(int value, {bool isReset = false}) {
    voteCount.value = value;
  }

  void callAction(int indexChoosedCard) {
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
    var otherObject = gameManagement.dataPlayer[indexChoosedCard];

    if (maxUseSkill == 0) {
      return;
    }

    if (listChoosedOfIndex.length < maxChoose &&
        !listChoosedOfIndex.contains(indexChoosedCard)) {
      chooseAction(indexChoosedCard);
      listChoosedOfIndex.add(indexChoosedCard);
    } else if (!gameManagement
        .dataPlayer[listChoosedOfIndex[0]].isChoose.value) {
      listChoosedOfIndex.clear();
      callAction(indexChoosedCard);
    } else if (listChoosedOfIndex.contains(indexChoosedCard)) {
      listChoosedOfIndex.remove(indexChoosedCard);
      otherObject.isChoose.value = false;
    } else {
      CommonSnackbar()
          .warning(title: "Warning", subtitle: "Kamu sudah memilih");
    }
  }

  void chooseAction(int indexChoosedCard) {}

  bool canKill() {
    if (isProtected.value) {
      return false;
    } else {
      return true;
    }
  }

  Widget basicAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bangunkan",
                  style: MyText.subtitle(),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${dataCard.roleName}",
                  style: MyText.title(color: MyColors.varianBlue),
                )
              ],
            ),
            Text(
              defaultPerintah,
              textAlign: TextAlign.center,
              style: MyText.subtitle(),
            ),
          ],
        ),
      ),
    );
  }

  ///untuk seting choose
  void chooseSet(bool value) {
    isChoose.value = value;
  }

  void silentSet(bool value) {
    isSilent.value = value;
  }
}
