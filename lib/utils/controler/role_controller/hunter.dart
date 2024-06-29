import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/models/models.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/cards/card.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class Hunter extends BaseRole {
  Hunter()
      : super(
            dataCard: new DataCard(
                id: RoleId.hunter,
                roleName: "Hunter",
                description:
                    "Saat Hunter terbunuh oleh werewolf maka hunter dapat memilih 1 werewolf untuk di ajak mati",
                image: "assets/image/role/hunter.jpg"),
  defaultPerintah: "Tembak mati pemain lain"
  );

  int maxAction = 1;
  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
  late VoidCallback sendToLastNightAction;


  @override
  void onInit() {
    sendToLastNightAction = () => ActionOnKill();

    ever(isKill,(_){
      if(isKill.value == false){
        gameManagement.lastNightAction.remove(sendToLastNightAction);
      }
    });
    super.onInit();
  }

  @override
  void chooseAction(int indexChoosedCard) {
    if(isKill.value){
      gameManagement.displayPromt.add(Konfirmasibox(
          onPressed: ()=>killPlayer(indexChoosedCard), title: "Apakah anda yakin ingin membunuh?"));
      listChoosedOfIndex.add(indexChoosedCard);
    }
    super.chooseAction(indexChoosedCard);
  }

  void killPlayer(int indexChoosedCard) {
    var otherCard = gameManagement.dataPlayer[indexChoosedCard];
    listChoosedOfIndex.clear();
    otherCard.kill(this);
    gameManagement.displayPromt.clear();
    gameManagement.goMorning();
  }


  @override
  void kill(BaseRole killer) {
    if (killer.dataCard.id == RoleId.werewolf) {
      GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
      gameManagement.addLastNightAction(sendToLastNightAction);
    }

    isKill.value = true;
    chooseSet(false);
    super.kill(killer);
  }

  void ActionOnKill() {
    print('called action on kill');
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
    gameManagement.updatePosisionScrollWithObject(dataPlayer: this, scrollValue: 90);
    gameManagement.updateActiveRoleWithPlayerData(dataPlayer: this);
    gameManagement.displayPromt.add(promptHunterInvitePlayerDies());
  }

  Widget promptHunterInvitePlayerDies() {
    return Center(
      child: Text(
        "Bangunkan Hunter dan minta hunter memilih 1 player random",
        style: MyText.title(),
        textAlign: TextAlign.center,
      ),
    );
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
        title: "Next Aja!!",
    buttonTitle: "Next",
    );
  }
}
