import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/controller/promt_display_controller.dart';

class PromtDisplay extends GetView<PromtDisplayController> {
  const PromtDisplay({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");

    return Container(
      width: screenWidth,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.primaryColor,
        border: Border.all(color: MyColors.outline, width: 4),
      ),
      child: Obx(() => Center(
          child: gameManagement.displayPromt.length > 0
              ? gameManagement.displayPromt[gameManagement.displayPromtIndex]
              : gameManagement
                  .listDefaultPromt[gameManagement.defaultPromtIndex])),
    );
  }
}
