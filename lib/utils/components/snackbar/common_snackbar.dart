import 'dart:async';
import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/snackbar/common_snackbar_controller.dart';

class CommonSnackbar extends GetView<CommonSnackbarController> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void warning(
      {int duration = 3,
      required String title,
      required String subtitle}) {
    if (!controller.isShoweWrongSB) {
      controller.isShoweWrongSB = true;
      Get.snackbar(title, subtitle,
          backgroundColor: MyColors.varianRed,
          duration: Duration(seconds: duration),
          animationDuration: Duration(milliseconds: 300)
      );

      Timer(Duration(seconds: duration), () {
        controller.isShoweWrongSB = false;
      });
    }
  }

  void snackbarCorect({required BuildContext context, int duration = 3}) {
    if (!controller.isShoweWrongSB) {
      controller.isShoweWrongSB = true;
      Get.snackbar("Jeniuss", "Ilmu Padi Abangkuuuu🔥🔥🔥🔥",
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: Duration(seconds: duration));

      Timer(Duration(seconds: duration), () {
        controller.isShoweWrongSB = false;
        print('timer finis');
      });
    }
  }
}
