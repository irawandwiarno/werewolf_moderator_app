import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/models/data_card_model.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/cards/card.dart';
import 'package:ww_moderator/utils/components/controller/card_role_and_name_controller.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';

class PlayerDisplay extends StatelessWidget {
  const PlayerDisplay({
    super.key,
    required this.deks,
  });

  final RxList<BaseRole> deks;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MyColors.varianRed,
            border: Border.all(color: MyColors.outline, width: 4)),
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            itemCount: deks.length,
            itemBuilder: (context, index) {
              return CardRoleAndNamePlayer(
                screenWidth: screenWidth,
                tagController: "CRANC${index + 1}",
                indexOfCard: index,
              );
            }),
      ),
    );
  }
}
