import 'package:ww_moderator/modules/select_card_role/select_card_controller.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';

class CardPlusMinController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  SelectCardController selectCardController = Get.find<SelectCardController>();


  var count = 0.obs;

  void plus({required int roleId}) {
    selectCardController.tambahData(index: roleId);
    count.value++;
  }

  void min({required int roleId}) {
    if (count.value > 0) {
      selectCardController.kurangiData(index: roleId);
      count.value--;
    }
  }
}
