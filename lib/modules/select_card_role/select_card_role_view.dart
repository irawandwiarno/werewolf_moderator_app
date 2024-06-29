import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/modules/select_card_role/select_card_controller.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/cards/card_plus_min.dart';
import 'package:ww_moderator/utils/components/controller/card_plus_min_controller.dart';

class SelectCardRoleView extends GetView<SelectCardController> {
  SelectCardRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.backgroundApp,
      appBar: AppBar(
        title: Obx(
          () => Text(
            "Jumlah Pemain: ${controller.tempCard.length}",
            style: MyText.h3(),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: controller.listCardRole.length,
          itemBuilder: (context, index) {
            Get.put(CardPlusMinController(), tag: "CPMC$index");
            return CardPlusMin(
              cardRole: controller.listCardRole[index],
              tag: "CPMC$index",
            );
          }),
    ));
  }
}
