import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/controller/card_plus_min_controller.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';

class CardPlusMin extends StatelessWidget {
  CardPlusMin({required this.cardRole, required this.tag});
  final BaseRole cardRole;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final CardPlusMinController controller =
        Get.find<CardPlusMinController>(tag: tag);
    return Card(
      color: MyColors.bgCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: MyColors.outline, width: 4), // Outline color and width
          borderRadius:
              BorderRadius.circular(15.0), // Same as Card's borderRadius
        ),
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Image section
            Container(
              width: 100,
              color: Colors.grey, // Placeholder for the image
              child: Image.asset(
                cardRole.dataCard.image, // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.0),
            // Content section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardRole.dataCard.roleName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    cardRole.dataCard.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () =>
                            controller.min(roleId: cardRole.dataCard.id),
                      ),
                      Container(
                        width: 40,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Obx(
                          () => Text(
                            controller.count.value.toString(),
                            style: MyText.title(color: MyColors.outline),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () =>
                            controller.plus(roleId: cardRole.dataCard.id),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
