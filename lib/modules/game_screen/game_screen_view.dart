import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/cards/card.dart';

class GameScreenView extends StatelessWidget {
   GameScreenView({super.key});

   @override
   Widget build(BuildContext context) {
     GameManagement controller = Get.find<GameManagement>(tag: "GM");
     double screenWidth = MediaQuery.of(context).size.width;
     double screenHight = MediaQuery.of(context).size.height;
     double gap = 10;

     return Scaffold(
       backgroundColor: MyColors.backgroundApp,
       body: SafeArea(
           child: Padding(
             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
             child: Column(
               children: [
                 DeksCard(
                   screenWidth: screenWidth,
                   deks: controller.dataRole
                 ),
                 SizedBox(
                   height: gap,
                 ),
                 PromtDisplay(screenWidth: screenWidth),
                 SizedBox(
                   height: gap,
                 ),
                 PlayerDisplay(deks:controller.dataPlayer),
               ],
             ),
           )),
     );
   }
}
