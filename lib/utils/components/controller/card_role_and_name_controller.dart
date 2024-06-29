import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/base_role.dart';

class CardRoleAndNameController extends GetxController {
  CardRoleAndNameController({
    required this.indexOfCard,
  });

  late GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
  TextEditingController textEditingController = TextEditingController();

  final int indexOfCard;
  var isEditName = false.obs;
  BaseRole? dataPlayer;

  @override
  void onInit() {
    dataPlayer = gameManagement.dataPlayer[indexOfCard];
    super.onInit();
  }

  void plusAction() {
    dataPlayer!.voteCountChange(dataPlayer!.voteCount.value + 1);
  }

  void minusAction() {
    if (dataPlayer!.voteCount > 0) {
      dataPlayer!.voteCountChange(dataPlayer!.voteCount.value - 1);
    }
  }

  void onPressedIconButon() {
    isEditName.value = true;
  }

  void saveAction() {
    if (textEditingController.text.trim() != "") {
      dataPlayer!.dataCard.playerName = textEditingController.text;
    }
    isEditName.value = false;
  }

  void cancelAction() {
    isEditName.value = false;
    textEditingController.text = dataPlayer!.dataCard.playerName;
  }

  void onChoose({required int indexChoosedCard}) {
    gameManagement.activeRole.value.callAction(indexChoosedCard);
  }
}
