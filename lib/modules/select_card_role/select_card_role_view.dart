import 'dart:math';

import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/cursed.dart';
import 'package:ww_moderator/utils/controler/role_controller/doppelganger.dart';
import 'package:ww_moderator/utils/controler/role_controller/drunk.dart';
import 'package:ww_moderator/utils/controler/role_controller/priest.dart';
import 'package:ww_moderator/utils/controler/role_controller/bodyguard.dart';
import 'package:ww_moderator/utils/controler/role_controller/mistyc_seer.dart';
import 'package:ww_moderator/utils/controler/role_controller/prince.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_controller/spellcaster.dart';
import 'package:ww_moderator/utils/controler/role_controller/werewolf.dart';
import 'package:ww_moderator/utils/controler/role_controller/witch.dart';

class SelectCardRoleView extends StatelessWidget {
  SelectCardRoleView({super.key});

  var dataPlayer = RxList<BaseRole>([
    Get.find<Villager>(tag: "villager1"),
    Get.find<Villager>(tag: "villager2"),
    Get.find<Hunter>(tag: "hunter1"),
    Get.find<Seer>(tag: "seer1"),
    Get.find<Werewolf>(tag: "werewolf1"),
    Get.find<Werewolf>(tag: "werewolf2"),
    Get.find<Bodyguard>(tag: "bodyguard1"),
    Get.find<MysticSeer>(tag: "mysticseer1"),
    Get.find<Witch>(tag: "witch1"),
    Get.put(Spellcaster(),tag: "spellcaster1"),
    Get.put(Priest(),tag: "priest1"),
    Get.put(Prince(),tag: "prince1"),
    Get.put(Troblemaker(),tag: "troblemaker1"),
    Get.put(Doppelganger(),tag: "doppelganger1"),
    Get.put(Cursed(),tag: "cursed1"),
  ]);

  int getRandomIndex(List<BaseRole> players, {int? excludeId}) {
    if (players.isEmpty) {
      throw Exception("The players list is empty.");
    }
    Random random = Random();
    int randomIndex = random.nextInt(players.length);

    if (excludeId != null && players[randomIndex].dataCard.id == excludeId) {
      return getRandomIndex(players, excludeId: excludeId); // Recursively call the function
    }

    return randomIndex;
  }


  @override
  Widget build(BuildContext context) {
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
    return SafeArea(
        child: Center(
      child: ElevatedButton(
        onPressed: () {
          gameManagement.addDataPlayer(
              dataPlayer: dataPlayer);
          Get.toNamed(RouteName.gameScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Background color
          overlayColor: Colors.white, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Rounded corners
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 12), // Padding
        ),
        child: const Text(
          'Play',
          style: TextStyle(fontSize: 16),
        ),
      ),
    ));
  }
}
