import 'package:ww_moderator/exports.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/base_role.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Troblemaker extends BaseRole {
  Troblemaker()
      : super(
            dataCard: new DataCard(
                id: RoleId.troblemaker,
                roleName: "Troblemaker",
                description:
                    "Troublemaker memiliki kemampuan untuk menukar kartu peran dua pemain lain selama fase malam, tanpa melihat kartu-kartu tersebut",
                image: "assets/image/role/troublemaker.jpg"),
  defaultPerintah: "Gunakan kekuatan untuk membunuh player 1 kali dalam permainan"
  );

  int maxChoose = 1;
  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  @override
  void onInit() {
    maxUseSkill = 1;
    super.onInit();
  }


  // @override
  // void chooseAction(int indexChoosedCard) {
  //   GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
  //
  //   if (choosedIndex.length < 2 && !choosedIndex.contains(indexChoosedCard)) {
  //     gameManagement.dataPlayer[indexChoosedCard].isChoose.value = true;
  //     choosedIndex.add(indexChoosedCard);
  //   }else if(choosedIndex.contains(indexChoosedCard) && gameManagement.dataPlayer[indexChoosedCard].isChoose.value == false){
  //     choosedIndex.clear();
  //     gameManagement.dataPlayer[indexChoosedCard].isChoose.value = true;
  //     choosedIndex.add(indexChoosedCard);
  //   }else if(choosedIndex.contains(indexChoosedCard)){
  //     gameManagement.dataPlayer[indexChoosedCard].isChoose.value = false;
  //     choosedIndex.remove(indexChoosedCard);
  //   }
  //
  //   super.chooseAction(indexChoosedCard);
  // }

  @override
  void chooseAction(int indexChoosedCard) {
    if(maxUseSkill == 0){
      return;
    }

    var objectPlayer = gameManagement.dataPlayer[indexChoosedCard];
    gameManagement.displayPromt.add(Konfirmasibox(
        onPressed: () {
          objectPlayer.kill(this);
          listChoosedOfIndex.clear();
          gameManagement.displayPromt.clear();
          maxUseSkill = maxUseSkill! - 1;
          gameManagement.nextPlayer();
        },
        title: "Apakah anda ingin membunuh?"));

    objectPlayer.isChoose.value = true;
    listChoosedOfIndex.add(indexChoosedCard);

    super.chooseAction(indexChoosedCard);
  }

  @override
  Widget basicAction() {
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
