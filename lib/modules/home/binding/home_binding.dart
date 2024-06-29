import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/utils/components/controller/card_role_and_name_controller.dart';
import 'package:ww_moderator/utils/components/snackbar/common_snackbar_controller.dart';

import '../home.dart';
import '../../../exports.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeControler());
    Get.put(GameManagement(), tag: "GM");
    Get.put(CommonSnackbarController(), permanent: true);
  }
}