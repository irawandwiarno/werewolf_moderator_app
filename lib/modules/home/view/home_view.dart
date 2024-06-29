import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/models/data_card_model.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/modules/home/home.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/cards/card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    GameManagement gameManagement = Get.find<GameManagement>(tag: "GM");
    return Scaffold(
      body: SafeArea(
          child: Container(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(RouteName.selectCardRole);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  overlayColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Padding
                ),
                child: Text(
                  'Play',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          )),
    );
  }
}


