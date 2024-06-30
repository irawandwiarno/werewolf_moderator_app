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
            "Pemain: ${controller.playerCount.value}",
            style: MyText.h4(),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.varianGreen,

            ),
              onPressed: ()=> controller.buttonMulai(),
              child: Text(
                "Mulai",
                style: MyText.h3(color: MyColors.defaultWhite),
              ))
        ],
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: controller.lengData,
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
