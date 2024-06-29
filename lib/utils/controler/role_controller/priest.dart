import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/exports.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/base_role.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Priest extends BaseRole {
  Priest()
      : super(
          dataCard: new DataCard(
              id: RoleId.priest,
              roleName: "Priest",
              description: "Dapat melindungi pemain 1 kali dalam permainan",
              image: "assets/image/role/priest.jpg"),
          defaultPerintah: "Apakah ingin melindungi pemain?",
        );

  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void onInit() {
    maxUseSkill = 1;
    super.onInit();
  }

  @override
  void chooseAction(int indexChoosedCard) {
    var otherObject = gameManagement.dataPlayer[indexChoosedCard];
    gameManagement.displayPromt.add(Konfirmasibox(onPressed: (){
      otherObject.protect();
      gameManagement.nextPlayer();
      maxUseSkill = maxUseSkill! - 1;
    }, title: "Yakin ingin melindungi?"));
    otherObject.chooseSet(true);
    super.chooseAction(indexChoosedCard);
  }

@override
Widget basicAction(){
  if (maxUseSkill != 0) {
    return Container(
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
              defaultPerintah,
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
    title: "Pemain Sudah menggunakan kekuatan",
    buttonTitle: "Next",
  );
}


}
