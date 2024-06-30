import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Mayor extends BaseRole {
  Mayor()
      : super(
      dataCard: new DataCard(
          id: RoleId.mayor,
          roleName: "Mayor",
          description: "Vote dari mayor di hitung 2",
          image: "assets/image/role/mayor.jpg"),
      defaultPerintah: "Next aja");

  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void chooseAction(int indexChoosedCard) {
    gameManagement.nextPlayer();
    super.chooseAction(indexChoosedCard);
  }

  @override
  Widget basicAction() {
    if(gameManagement.day == 1){
      return  Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bangunkan", style: MyText.subtitle(),),
                  SizedBox(width: 5,),
                  Text("${dataCard.roleName}", style: MyText.title(color: MyColors.varianBlue),)
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
