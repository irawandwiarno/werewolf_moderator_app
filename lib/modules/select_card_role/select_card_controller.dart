import 'dart:math';
import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class SelectCardController extends GetxController {
  var dataPlayer = RxList<BaseRole>([]);
  var lengData = 15;
  var playerCount = 0.obs;

  @override
  void onInit() {
    ever(roleCountMap, (_) => playerCount.value = countPlayer());
    super.onInit();
  }

  void loop() {
    // Villager
    for (int i = 0; i < roleCountMap["Villager"]!; i++) {
      Get.put(Villager(), tag: "villager${i + 1}");
      dataPlayer.add(Get.find<Villager>(tag: "villager${i + 1}"));
    }

    // Mayor
    for (int i = 0; i < roleCountMap["Mayor"]!; i++) {
      Get.put(Mayor(), tag: "mayor${i + 1}");
      dataPlayer.add(Get.find<Mayor>(tag: "mayor${i + 1}"));
    }

    // Prince
    for (int i = 0; i < roleCountMap["Prince"]!; i++) {
      Get.put(Prince(), tag: "prince${i + 1}");
      dataPlayer.add(Get.find<Prince>(tag: "prince${i + 1}"));
    }

    // Hunter
    for (int i = 0; i < roleCountMap["Hunter"]!; i++) {
      Get.put(Hunter(), tag: "hunter${i + 1}");
      dataPlayer.add(Get.find<Hunter>(tag: "hunter${i + 1}"));
    }

    // Cursed
    for (int i = 0; i < roleCountMap["Cursed"]!; i++) {
      Get.put(Cursed(), tag: "cursed${i + 1}");
      dataPlayer.add(Get.find<Cursed>(tag: "cursed${i + 1}"));
    }

    // Priest
    for (int i = 0; i < roleCountMap["Priest"]!; i++) {
      Get.put(Priest(), tag: "priest${i + 1}");
      dataPlayer.add(Get.find<Priest>(tag: "priest${i + 1}"));
    }

    // Doppelganger
    for (int i = 0; i < roleCountMap["Doppelganger"]!; i++) {
      Get.put(Doppelganger(), tag: "doppelganger${i + 1}");
      dataPlayer.add(Get.find<Doppelganger>(tag: "doppelganger${i + 1}"));
    }

    // Troblemaker
    for (int i = 0; i < roleCountMap["Troblemaker"]!; i++) {
      Get.put(Troblemaker(), tag: "troblemaker${i + 1}");
      dataPlayer.add(Get.find<Troblemaker>(tag: "troblemaker${i + 1}"));
    }

    // Spellcaster
    for (int i = 0; i < roleCountMap["Spellcaster"]!; i++) {
      Get.put(Spellcaster(), tag: "spellcaster${i + 1}");
      dataPlayer.add(Get.find<Spellcaster>(tag: "spellcaster${i + 1}"));
    }

    // Seer
    for (int i = 0; i < roleCountMap["Seer"]!; i++) {
      Get.put(Seer(), tag: "seer${i + 1}");
      dataPlayer.add(Get.find<Seer>(tag: "seer${i + 1}"));
    }

    // MysticSeer
    for (int i = 0; i < roleCountMap["MysticSeer"]!; i++) {
      Get.put(MysticSeer(), tag: "mysticseer${i + 1}");
      dataPlayer.add(Get.find<MysticSeer>(tag: "mysticseer${i + 1}"));
    }

    // Bodyguard
    for (int i = 0; i < roleCountMap["Bodyguard"]!; i++) {
      Get.put(Bodyguard(), tag: "bodyguard${i + 1}");
      dataPlayer.add(Get.find<Bodyguard>(tag: "bodyguard${i + 1}"));
    }

    // Witch
    for (int i = 0; i < roleCountMap["Witch"]!; i++) {
      Get.put(Witch(), tag: "witch${i + 1}");
      dataPlayer.add(Get.find<Witch>(tag: "witch${i + 1}"));
    }

    // Sorceress
    for (int i = 0; i < roleCountMap["Sorceress"]!; i++) {
      Get.put(Sorceress(), tag: "sorceress${i + 1}");
      dataPlayer.add(Get.find<Sorceress>(tag: "sorceress${i + 1}"));
    }

    // Werewolf
    for (int i = 0; i < roleCountMap["Werewolf"]!; i++) {
      Get.put(Werewolf(), tag: "werewolf${i + 1}");
      dataPlayer.add(Get.find<Werewolf>(tag: "werewolf${i + 1}"));
    }
  }

  var roleCountMap = {
    'Villager': 0,
    'Mayor': 0,
    'Prince': 0,
    'Hunter': 0,
    'Cursed': 0,
    'Priest': 0,
    'Doppelganger': 0,
    'Troblemaker': 0,
    'Spellcaster': 0,
    'Seer': 0,
    'MysticSeer': 0,
    'Bodyguard': 0,
    'Witch': 0,
    'Sorceress': 0,
    'Werewolf': 0,
  }.obs;

  void resetRoleCount() {
    roleCountMap.value = {
      'Villager': 0,
      'Mayor': 0,
      'Prince': 0,
      'Hunter': 0,
      'Cursed': 0,
      'Priest': 0,
      'Doppelganger': 0,
      'Troblemaker': 0,
      'Spellcaster': 0,
      'Seer': 0,
      'MysticSeer': 0,
      'Bodyguard': 0,
      'Witch': 0,
      'Sorceress': 0,
      'Werewolf': 0,
    };
  }

  var listCardRole = <BaseRole>[
    Villager(),
    Mayor(),
    Prince(),
    Hunter(),
    Cursed(),
    Priest(),
    Doppelganger(),
    Troblemaker(),
    Spellcaster(),
    Seer(),
    MysticSeer(),
    Bodyguard(),
    Witch(),
    Sorceress(),
    Werewolf()
  ];

  void buttonMulai() {
    loop();
    var gm = Get.find<GameManagement>(tag: "GM");
    if (gm.dataPlayer.isEmpty) {
      gm.addDataPlayer(dataPlayer: dataPlayer);
    }
    Get.toNamed(RouteName.gameScreen);
  }

  int countPlayer() {
    int total = 0;
    roleCountMap.forEach((key, value) {
      total += value;
    });
    return total;
  }

  void tambahData({required int index}) {
    switch (index) {
      case 1:
        roleCountMap["Villager"] = (roleCountMap["Villager"] ?? 0) + 1;
        break;
      case 3:
        roleCountMap["Mayor"] = (roleCountMap["Mayor"] ?? 0) + 1;
        break;
      case 4:
        roleCountMap["Prince"] = (roleCountMap["Prince"] ?? 0) + 1;
        break;
      case 6:
        roleCountMap["Hunter"] = (roleCountMap["Hunter"] ?? 0) + 1;
        break;
      case 7:
        roleCountMap["Cursed"] = (roleCountMap["Cursed"] ?? 0) + 1;
        break;
      case 10:
        roleCountMap["Priest"] = (roleCountMap["Priest"] ?? 0) + 1;
        break;
      case 11:
        roleCountMap["Doppelganger"] = (roleCountMap["Doppelganger"] ?? 0) + 1;
        break;
      case 12:
        roleCountMap["Troblemaker"] = (roleCountMap["Troblemaker"] ?? 0) + 1;
        break;
      case 13:
        roleCountMap["Spellcaster"] = (roleCountMap["Spellcaster"] ?? 0) + 1;
        break;
      case 14:
        roleCountMap["Seer"] = (roleCountMap["Seer"] ?? 0) + 1;
        break;
      case 15:
        roleCountMap["MysticSeer"] = (roleCountMap["MysticSeer"] ?? 0) + 1;
        break;
      case 16:
        roleCountMap["Bodyguard"] = (roleCountMap["Bodyguard"] ?? 0) + 1;
        break;
      case 18:
        roleCountMap["Witch"] = (roleCountMap["Witch"] ?? 0) + 1;
        break;
      case 19:
        roleCountMap["Sorceress"] = (roleCountMap["Sorceress"] ?? 0) + 1;
        break;
      case 20:
        roleCountMap["Werewolf"] = (roleCountMap["Werewolf"] ?? 0) + 1;
        break;
      default:
        throw Exception("Invalid Role index");
    }
  }

  void kurangiData({required int index}) {
    switch (index) {
      case 1:
        roleCountMap["Villager"] = (roleCountMap["Villager"] ?? 0) - 1;
        if (roleCountMap["Villager"]! < 0) {
          roleCountMap["Villager"] = 0;
        }
        break;
      case 3:
        roleCountMap["Mayor"] = (roleCountMap["Mayor"] ?? 0) - 1;
        if (roleCountMap["Mayor"]! < 0) {
          roleCountMap["Mayor"] = 0;
        }
        break;
      case 4:
        roleCountMap["Prince"] = (roleCountMap["Prince"] ?? 0) - 1;
        if (roleCountMap["Prince"]! < 0) {
          roleCountMap["Prince"] = 0;
        }
        break;
      case 6:
        roleCountMap["Hunter"] = (roleCountMap["Hunter"] ?? 0) - 1;
        if (roleCountMap["Hunter"]! < 0) {
          roleCountMap["Hunter"] = 0;
        }
        break;
      case 7:
        roleCountMap["Cursed"] = (roleCountMap["Cursed"] ?? 0) - 1;
        if (roleCountMap["Cursed"]! < 0) {
          roleCountMap["Cursed"] = 0;
        }
        break;
      case 10:
        roleCountMap["Priest"] = (roleCountMap["Priest"] ?? 0) - 1;
        if (roleCountMap["Priest"]! < 0) {
          roleCountMap["Priest"] = 0;
        }
        break;
      case 11:
        roleCountMap["Doppelganger"] = (roleCountMap["Doppelganger"] ?? 0) - 1;
        if (roleCountMap["Doppelganger"]! < 0) {
          roleCountMap["Doppelganger"] = 0;
        }
        break;
      case 12:
        roleCountMap["Troblemaker"] = (roleCountMap["Troblemaker"] ?? 0) - 1;
        if (roleCountMap["Troblemaker"]! < 0) {
          roleCountMap["Troblemaker"] = 0;
        }
        break;
      case 13:
        roleCountMap["Spellcaster"] = (roleCountMap["Spellcaster"] ?? 0) - 1;
        if (roleCountMap["Spellcaster"]! < 0) {
          roleCountMap["Spellcaster"] = 0;
        }
        break;
      case 14:
        roleCountMap["Seer"] = (roleCountMap["Seer"] ?? 0) - 1;
        if (roleCountMap["Seer"]! < 0) {
          roleCountMap["Seer"] = 0;
        }
        break;
      case 15:
        roleCountMap["MysticSeer"] = (roleCountMap["MysticSeer"] ?? 0) - 1;
        if (roleCountMap["MysticSeer"]! < 0) {
          roleCountMap["MysticSeer"] = 0;
        }
        break;
      case 16:
        roleCountMap["Bodyguard"] = (roleCountMap["Bodyguard"] ?? 0) - 1;
        if (roleCountMap["Bodyguard"]! < 0) {
          roleCountMap["Bodyguard"] = 0;
        }
        break;
      case 18:
        roleCountMap["Witch"] = (roleCountMap["Witch"] ?? 0) - 1;
        if (roleCountMap["Witch"]! < 0) {
          roleCountMap["Witch"] = 0;
        }
        break;
      case 19:
        roleCountMap["Sorceress"] = (roleCountMap["Sorceress"] ?? 0) - 1;
        if (roleCountMap["Sorceress"]! < 0) {
          roleCountMap["Sorceress"] = 0;
        }
        break;
      case 20:
        roleCountMap["Werewolf"] = (roleCountMap["Werewolf"] ?? 0) - 1;
        if (roleCountMap["Werewolf"]! < 0) {
          roleCountMap["Werewolf"] = 0;
        }
        break;
      default:
        throw Exception("Invalid Role index");
    }
  }
}
