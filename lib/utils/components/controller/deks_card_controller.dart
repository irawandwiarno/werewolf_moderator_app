import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/components.dart';
import 'package:ww_moderator/utils/components/controller/timer_controller.dart';
import 'package:ww_moderator/utils/controler/role_id.dart';

class DeksCardController extends GetxController {
  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
  final ScrollController scrollController = ScrollController();
  List<int> listTime = [3, 5, 10];
  TimerCountDownController timerController =
      Get.find<TimerCountDownController>();

  @override
  void onInit() {
    super.onInit();
  }

  void prevButton() {
    int indexActiveRole = gameManagement.dataRole
        .indexWhere((data) => data == gameManagement.activeRole.value);
    if (indexActiveRole > 0) {
      gameManagement.activeRole.value =
          gameManagement.dataRole[indexActiveRole - 1];

      scrollActionPrev(scrollValue: 90, index: indexActiveRole);
    }

    gameManagement.displayPromt.add(gameManagement.activeRole.value.basicAction());
  }

  void nextButton({bool skipToMorning = false}) {
    int indexActiveRole = gameManagement.dataRole
        .indexWhere((data) => data == gameManagement.activeRole.value);

    if (isDayRole()) {
      nextDayAction();
      return;
    }

    if (shouldShowNightActionDialog(indexActiveRole)) {
      showNightActionDialog();
      return;
    }

    if (shouldShowEndNightDialog(indexActiveRole)) {
      showEndNightDialog();
      return;
    }

    moveToNextRole(indexActiveRole);
    addFirstPrompt();
  }

  void goMorning() {
    if (gameManagement.lastNightAction.isNotEmpty) {
      showNightActionDialog();
      print('called full');
      return;
    }
    print('go mor call');
    showEndNightDialog();
  }

  bool isDayRole() {
    return gameManagement.activeRole.value.dataCard.id == RoleId.day;
  }

  bool shouldShowNightActionDialog(int indexActiveRole) {
    return gameManagement.lastNightAction.isNotEmpty &&
        indexActiveRole == gameManagement.dataRole.length - 1;
  }

  void showNightActionDialog() {
    MyDialog().normal(
      title: "Ada beberapa role teraktifasi",
      subtitle: "Call they role?",
      action: () => lastActionAtNightRun(),
    );
  }

  bool shouldShowEndNightDialog(int indexActiveRole) {
    return indexActiveRole == gameManagement.dataRole.length - 1;
  }

  void showEndNightDialog() {
    print('show end call');
    MyDialog().normal(
      title: "Konfirmasi",
      subtitle: "Yakin ingin menyelesaikan sesi malam hari?",
      action: () => gameManagement.setDaySectionTime(display: TimerDiscus()),
    );
  }

  void moveToNextRole(int indexActiveRole) {
    if (indexActiveRole < gameManagement.dataRole.length - 1) {
      gameManagement.activeRole.value =
          gameManagement.dataRole[indexActiveRole + 1];
      scrollActionNext(scrollValue: 90, index: indexActiveRole);
    }
  }

  void addFirstPrompt() {
    gameManagement.displayPromt
        .add(gameManagement.activeRole.value.basicAction());
  }

  void nextDayAction() {
    gameManagement.updateActiveRole(indexOfCard: 0);
    scrollActionPrev(scrollValue: 90, index: 0);
    gameManagement.resetDataForNextDay();
    addFirstPrompt();
    gameManagement.day++;
  }

  void scrollActionPrev(
      {required double scrollValue, int? duration, int? index}) async {
    double offset = scrollController.offset + scrollValue;
    if (index != null) {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: duration ?? 1),
        curve: Curves.easeInOut,
      );
      offset = index * scrollValue - scrollValue;
    }
    scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: duration ?? 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollActionNext(
      {required double scrollValue, int? duration, int? index}) async {
    double offset = scrollController.offset + scrollValue;
    if (index != null) {
      scrollController.animateTo(
        0,
        duration: Duration(milliseconds: duration ?? 1),
        curve: Curves.easeInOut,
      );
      offset = index * scrollValue;
    }
    scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: duration ?? 300),
      curve: Curves.easeInOut,
    );
  }

  void scrollToIndex(
      {required int index, required double scrollValue, int? duration}) {
    resetScroll();
    double offset = scrollValue * index;
    scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: duration ?? 300),
      curve: Curves.easeInOut,
    );
  }

  void isDaySection() {
    if (gameManagement.activeRole.value.dataCard.id == RoleId.day) {
      gameManagement.displayPromt.add(TimerDiscus());
    }
  }

  void resetScroll() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void lastActionAtNightRun() {
    gameManagement.runLastNightAction();
    Future.delayed(const Duration(seconds: 2));
  }

  Widget TimerDiscus() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      height: 100,
      child: Center(
        child: ListView.builder(
            itemCount: listTime.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 60),
            itemBuilder: (context, index) => ButtonTimer(index: index)),
      ),
    );
  }

  void cancelTimer() {
    timerController.stopTimer();
  }

  Widget TimerDisplay() {
    return Center(
      child: Column(
        children: [
          Obx(() => Text(
                timerController.timerFormater(),
                style: MyText.h2(),
              )),
          Container(
            width: 70,
            child: ElevatedButton(
              onPressed: () => cancelTimer(),
              style: ElevatedButton.styleFrom(
                elevation: 3,
                backgroundColor: Colors.green,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Sudut membulat
                ),
              ),
              child: Center(
                  child: Text(
                "Lewati",
                style: MyText.title(color: MyColors.defaultWhite),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget ButtonTimer({required int index}) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: ElevatedButton(
        onPressed: () =>
            timerController.startTimer(listTime[index], TimerDisplay()),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: Colors.green,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Sudut membulat
          ),
        ),
        child: Center(
            child: Text(
          listTime[index].toString(),
          style: MyText.title(),
        )),
      ),
    );
  }
}
