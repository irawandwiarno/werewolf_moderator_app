import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Cursed extends BaseRole {
  Cursed()
      : super(
            dataCard: new DataCard(
                id: RoleId.cursed,
                roleName: "Cursed",
                description:
                    "Jika di bunuh oleh werewolf maka akan jadi werewolf",
                image: "assets/image/role/cursed.jpg"),
            defaultPerintah: "Next aja");

  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
  late VoidCallback sendToLastNightAction;

  @override
  void onInit() {
    sendToLastNightAction = () => ActionOnKill();

    super.onInit();
  }

  @override
  void chooseAction(int indexChoosedCard) {
    gameManagement.nextPlayer();
    super.chooseAction(indexChoosedCard);
  }

  @override
  void kill(BaseRole killer) {
    if (canKill()) {
      if (killer.dataCard.id == RoleId.werewolf) {
        GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
        gameManagement.addLastNightAction(sendToLastNightAction);
      }
    }
  }

  void ActionOnKill() {
    gameManagement.updatePosisionScrollWithObject(
        dataPlayer: this, scrollValue: 90);
    gameManagement.updateActiveRoleWithPlayerData(dataPlayer: this);
    gameManagement.displayPromt.add((promptBeritahuCursed()));
  }

  Widget promptBeritahuCursed() {
    return Konfirmasibox(
      onPressed: () {
        MyDialog().displayText(
            title: "Werewolf",
            onTap: () {
              print('${gameManagement.lastNightAction.length} sssss');
              gameManagement.goMorning();
            });
      },
      title: "Tampilkan Role Baru",
      buttonColor: MyColors.varianGreen,
      buttonTitle: "Tampilkan",
    );
  }

  @override
  Widget basicAction() {
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
