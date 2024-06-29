import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/controller/deks_card_controller.dart';
import 'package:ww_moderator/utils/controler/role_controller/base_role.dart';
import 'package:ww_moderator/utils/controler/role_controller/day_section.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class GameManagement extends GetxController {
  RxList<BaseRole> dataPlayer = <BaseRole>[].obs;
  RxList<BaseRole> dataRole = <BaseRole>[].obs;
  late Rx<BaseRole> activeRole = dataPlayer[0].obs;
  BaseRole dataDay = Get.put(DaySection());
  int day = 1;
  int defaultPromtIndex = 0;
  int displayPromtIndex = 0;
  RxBool voteTime = false.obs;
  RxList<Widget> listDefaultPromt = <Widget>[
    Text(
      "Default prompt",
      style: MyText.h3(),
    )
  ].obs;
  RxList<Widget> displayPromt = <Widget>[].obs;
  RxList<void Function()> lastNightAction = <void Function()>[].obs;
  RxList<Widget> lastMoveInNightWidget = <Widget>[].obs;
  late DeksCardController deksCardController = Get.find<DeksCardController>();

  void ekstrakDataPlayerToDataRole() {
    Map<int, BaseRole> uniquePlayersMap = {};

    for (var player in dataPlayer) {
      if (!uniquePlayersMap.containsKey(player.dataCard.id)) {
        uniquePlayersMap[player.dataCard.id] = player;
      }
    }

    dataRole.addAll(uniquePlayersMap.values);
    print('data role: ${dataRole.toString()}');

    for (var player in dataRole) {
      print('Id: ${player.dataCard.id}, Name: ${player.dataCard.roleName}');
    }
  }

  void addLastNightAction(VoidCallback action) {
    lastNightAction.add(action);
  }

  void runLastNightAction() {
    if (lastNightAction.isNotEmpty) {
      lastNightAction[0]();
      popLastNightAction();
    }
  }

  void popLastNightAction() {
    lastNightAction.removeAt(0);
  }

  void nextPlayer() {
    deksCardController.nextButton();
  }

  void goMorning(){
    deksCardController.goMorning();
  }

  void setVoteTime({required bool newValue}) {
    voteTime.value = newValue;
  }

  void voteReset() {
    for (var player in dataPlayer) {
      player.voteCountChange(0, isReset: true);
    }
    voteTime.value = false;
  }

  void protectedReset() {
    for (var player in dataPlayer) {
      if (player.isProtected.value) {
        player.isProtected.value = false;
      }
    }
  }

  void silentReset() {
    for (var player in dataPlayer) {
      if (player.isSilent.value) {
        player.isSilent.value = false;
      }
    }
  }

  void addToBackDataPlayerDead() {
    // Filter players that are killed
    var killedPlayers =
        dataPlayer.where((player) => player.isKill.value).toList();

    // Mark them as dead and remove from the original list
    for (var player in killedPlayers) {
      player.dead(true);
      // dataPlayer.remove(player);
    }

    // Add killed players to the end of the list
    // dataPlayer.addAll(killedPlayers);
  }

  void resetDataForNextDay() {
    voteReset();
    protectedReset();
    silentReset();
    addToBackDataPlayerDead();
  }

  void nextDayAction() {
    deksCardController.nextDayAction();
  }

  ///cari vote terbanyak
  int findVoteTerbanyak() {
    if (dataPlayer.isEmpty) return -1;

    // Temukan data dengan vote tertinggi
    var maxVotePlayer = dataPlayer
        .reduce((a, b) => a.voteCount.value > b.voteCount.value ? a : b);

    // Hitung berapa banyak data yang memiliki vote tertinggi
    int maxVoteCount = dataPlayer
        .where(
            (player) => player.voteCount.value == maxVotePlayer.voteCount.value)
        .length;

    // Jika lebih dari satu data memiliki vote tertinggi, kembalikan -1
    if (maxVoteCount > 1) return -1;

    // Jika hanya satu data yang memiliki vote tertinggi, kembalikan indeksnya
    return findIndexDataPlayer(dataPlayer: maxVotePlayer);
  }

  void addDataPlayer({required RxList<BaseRole> dataPlayer}) {
    this.dataPlayer = dataPlayer;
    ever(activeRole, (_) {
      for (var player in dataPlayer) {
        player.isChoose.value = false;
      }
    });
    ever(displayPromt, (_) {
      if (displayPromt.isNotEmpty) {
        displayPromtIndex = displayPromt.length - 1;
      }
    });
    sortDataPlayer();
    ekstrakDataPlayerToDataRole();
    updateActiveRole(indexOfCard: 0);
    activeRole.value = dataRole[0];
    displayPromt.add(activeRole.value.basicAction());
  }

  void sortDataPlayer() {
    dataPlayer.sort((a, b) => b.dataCard.id.compareTo(a.dataCard.id));
  }

  void displayPromptNext() {
    if (displayPromt.isNotEmpty) {
      displayPromt.clear();
    } else {
      displayPromtIndex++;
      if (displayPromt.length - 1 < displayPromtIndex) {
        displayPromt.clear();
        displayPromtIndex = 0;
      }
    }
  }

  void resetDataPlayer() {
    dataPlayer = RxList<BaseRole>([]);
  }

  void updateActiveRole({required int indexOfCard}) {
    activeRole.value = dataPlayer[indexOfCard];
  }

  void updateActiveRoleWithPlayerData({required BaseRole dataPlayer}) {
    final index = this
        .dataPlayer
        .indexWhere((data) => data.dataCard.id == dataPlayer.dataCard.id);
    if (index != -1) {
      updateActiveRole(indexOfCard: index);
    }
  }

  void setDaySectionTime({required Widget display}) {
    displayPromt.add(display);
    activeRole.value = dataDay;
    deksCardController.resetScroll();
  }

  void updatePosisionScrollWithObject(
      {required BaseRole dataPlayer,
      required double scrollValue,
      int? duration}) {
    int index = findIndexDataRole(dataPlayer: dataPlayer);
    deksCardController.scrollToIndex(index: index, scrollValue: scrollValue);
  }

  int findIndexDataRole({required BaseRole dataPlayer}) {
    final index = dataRole
        .indexWhere((data) => data.dataCard.id == dataPlayer.dataCard.id);

    return index;
  }

  int findIndexDataPlayer({required BaseRole dataPlayer}) {
    final index = this.dataPlayer.indexWhere((data) => data == dataPlayer);

    return index;
  }

  void updateDataPlayerAtIndex(
      {required int index, required BaseRole newValue}) {
    if (index >= 0 && index < dataPlayer.length) {
      dataPlayer[index] = newValue;
    }
  }
}
