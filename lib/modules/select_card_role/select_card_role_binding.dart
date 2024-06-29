import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/bodyguard.dart';
import 'package:ww_moderator/utils/controler/role_controller/mistyc_seer.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_controller/werewolf.dart';
import 'package:ww_moderator/utils/controler/role_controller/witch.dart';

class SelectCardRoleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(Villager(), tag: "villager1");
    Get.put(Villager(), tag: "villager2");
    Get.put(Villager(), tag: "villager3");
    Get.put(Troblemaker(), tag: "troblemaker1");
    Get.put(Hunter(), tag: "hunter1");
    Get.put(Seer(), tag: "seer1");
    Get.put(Werewolf(), tag: "werewolf1");
    Get.put(Werewolf(), tag: "werewolf2");
    Get.put(Bodyguard(), tag: "bodyguard1");
    Get.put(MysticSeer(),tag: "mysticseer1");
    Get.put(Witch(),tag: "witch1");

  }
}