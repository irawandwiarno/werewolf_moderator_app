import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/controller/deks_card_controller.dart';
import 'package:ww_moderator/utils/components/controller/promt_display_controller.dart';
import 'package:ww_moderator/utils/components/controller/timer_controller.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';

class GameBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TimerCountDownController());
    Get.put(PromtDisplayController());
    Get.put(DeksCardController());
  }
}