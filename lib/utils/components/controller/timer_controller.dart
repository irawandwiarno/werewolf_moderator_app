import 'package:flutter/cupertino.dart';
import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/exports.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/controler/role_controller/base_role.dart';

class TimerCountDownController extends GetxController {
  // Sisa waktu dalam detik
  var _remainingMinut = 0.obs;
  var _remainingSeconds = 0.obs;
  GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

  // Timer
  Timer? _timer;

  // Mulai timer
  void startTimer(int durationInMinit, Widget display) {
    gameManagement.displayPromt.add(display);
    _remainingMinut.value = durationInMinit;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds.value > 0) {
        _remainingSeconds.value--;
      } else if (_remainingSeconds <= 0 && _remainingMinut > 0) {
        _remainingMinut -= 1;
        _remainingSeconds.value = 60;
        _remainingSeconds.value--;
      } else {
        _timer!.cancel();
        onTimerFinished();
      }
    });
  }

  String timerFormater() {
    String stringMenit = "$_remainingMinut";
    String stringDetik = "$_remainingSeconds";

    if (_remainingMinut < 10) {
      stringMenit = "0$_remainingMinut";
    }
    if (_remainingSeconds < 10) {
      stringDetik = "0$_remainingSeconds";
    }

    return "$stringMenit : $stringDetik";
  }

  // Hentikan timer
  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      onTimerFinished();
    }
  }

  // Callback saat timer selesai
  void onTimerFinished() {
    _remainingSeconds.value = 0;
    _remainingMinut.value = 0;
    gameManagement.setVoteTime(newValue: true);
    gameManagement.displayPromt.add(voteSection());
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  ///melakukan cheking apakah timer bisa di mulai
  void canStartTimer({required Widget display}) {
    if (_remainingMinut.value != 0 || _remainingSeconds.value != 0) {
      gameManagement.displayPromt.add(display);
    }
  }

  Widget voteSection() {
    return Konfirmasibox(
        onPressed: () {
          var indexTervote = gameManagement.findVoteTerbanyak();
          if (indexTervote < 0) {
            MyDialog().normal(
                title: "Tidak ada yang vote ter banyak",
                subtitle: "Tidak ada player yang memiliki vote terbanyak",
                action: () {
                  gameManagement.nextPlayer();
                });
            return;
          }
          MyDialog().normal(
              title:
                  "Anda yakin ingin vote ${gameManagement.dataPlayer[indexTervote].dataCard.playerName}",
              subtitle:
                  "orang ini memiliki vote sebanyak ${gameManagement.dataPlayer[indexTervote].voteCount.value}",
              action: () {
                Get.back();
                gameManagement.dataPlayer[indexTervote].vote();
              },
          withBack: false);
        },
        title: "Vote Time",
        buttonTitle: "Commit Vote");
  }
}
