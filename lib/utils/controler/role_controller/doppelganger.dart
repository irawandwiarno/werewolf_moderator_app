import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Doppelganger extends BaseRole {
  Doppelganger()
      : super(
            dataCard: new DataCard(
                id: RoleId.doppelganger,
                roleName: "Doppelganger",
                description:
                    "Nemilih pemain lain untuk di copy saat pemain tersebut mati",
                image: "assets/image/role/doppelganger.jpg"),
            defaultPerintah: "Next aja");

  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void chooseAction(int indexChoosedCard) {
    var otherObject = gameManagement.dataPlayer[indexChoosedCard];
    gameManagement.displayPromt.add(Konfirmasibox(
        onPressed: () {
          otherObject.deadCallbak
              .add(() => onMarkPlayerDead(otherObject.dataCard.roleName));
          gameManagement.nextPlayer();
        },
        title: "Anda yakin ingin mengcopy?"));
    super.chooseAction(indexChoosedCard);
  }

  void onMarkPlayerDead(String newRoleName) {
    MyDialog().normal(
        title: "Bangunkan ${dataCard.roleName}",
        subtitle: "Beritahu ${dataCard.roleName} role baru mereka",
        action: () {
          MyDialog().displayText(
              title: newRoleName,
              onTap: () {
                gameManagement.nextDayAction();
                Get.back();
              });
        },
        withBack: false);
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
                "Memilih pemain untuk di copy",
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
