import 'package:ww_moderator/modules/select_card_role/select_card_controller.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/controller/card_plus_min_controller.dart';

class SelectCardRoleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SelectCardController());
  }
}