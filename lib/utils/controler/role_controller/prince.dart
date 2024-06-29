import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Prince extends BaseRole {
  Prince()
      : super(
            dataCard: new DataCard(
                id: RoleId.prince,
                roleName: "Prince",
                description:
                    "Saat prince tervote maka prince dapat menunjukan kartunya pada pemain dan vote terbatalkan",
                image: "assets/image/role/prince.jpg"),
            defaultPerintah: "Next aja");

  bool revealCard = false;
  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void onInit() {
    maxUseSkill = 1;
    super.onInit();
  }

  @override
  void chooseAction(int indexChoosedCard) {
    var otherObject = gameManagement.dataPlayer[indexChoosedCard];
    if(revealCard){
      gameManagement.displayPromt.add(Konfirmasibox(onPressed: (){
        otherObject.dead(true);
        maxUseSkill = maxUseSkill! - 1;
        gameManagement.nextDayAction();
      }, title: "Yakin ingin vote?"));
      otherObject.chooseSet(true);
      return;
    }
    gameManagement.nextPlayer();
    super.chooseAction(indexChoosedCard);
  }

  @override
  void vote() {
    MyDialog().normal(
        title: "Price tidak dapat di vote!",
        subtitle:
            "Suruh prince membuka kartunya untuk mengungkap identitasnya kepada player lain, dan prince memiliki vote mutlak memilih 1 player untuk mati",
        action: () {
          Get.back();
          revealCard = true;
          gameManagement.voteReset();
          gameManagement.displayPromt.add(basicAction());
          gameManagement.updatePosisionScrollWithObject(dataPlayer: this, scrollValue: 90);
          gameManagement.updateActiveRoleWithPlayerData(dataPlayer: this);
        },
    );
  }

  @override
  void voteCountChange(int value, {bool isReset = false}) {
    if(revealCard && !isReset){
      CommonSnackbar().warning(title: "Prince tidak bisa di vote", subtitle: "Prince sudah menunjukna kartunya, tidak bisa di vote");
      return;
    }
    super.voteCountChange(value);
  }

  @override
  Widget basicAction() {
    if (revealCard && maxUseSkill != 0) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Pilih 1 player untuk di bunuh",
                textAlign: TextAlign.center,
                style: MyText.title(),
              ),
            ],
          ),
        ),
      );
    }

    if (gameManagement.day == 1) {
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
                "Untuk mendata nama player",
                textAlign: TextAlign.center,
                style: MyText.subtitle(),
              ),
            ],
          ),
        ),
      );
    }

    return Konfirmasibox(
      onPressed: () {
        gameManagement.nextPlayer();
      },
      title: "${defaultPerintah}",
      buttonTitle: "Next",
    );
  }
}
