import 'dart:math';

import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';

class SelectCardController extends GetxController {
  var dataPlayer = RxList<BaseRole>([]);

  var tempCard = <BaseRole>[].obs;

  var listCardRole = <BaseRole>[
    Villager(),
    Prince(),
    Hunter(),
    Priest(),
    Doppelganger(),
    Troblemaker(),
    Spellcaster(),
    Seer(),
    MysticSeer(),
    Bodyguard(),
    Witch(),
    Werewolf()
  ];


  int getRandomIndex(List<BaseRole> players, {int? excludeId}) {
    if (players.isEmpty) {
      throw Exception("The players list is empty.");
    }
    Random random = Random();
    int randomIndex = random.nextInt(players.length);

    if (excludeId != null && players[randomIndex].dataCard.id == excludeId) {
      return getRandomIndex(players,
          excludeId: excludeId); // Recursively call the function
    }

    return randomIndex;
  }
}
