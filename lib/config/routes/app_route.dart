import 'package:get/get.dart';
import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/modules/game_screen/game_binding.dart';
import 'package:ww_moderator/modules/game_screen/game_screen_view.dart';
import 'package:ww_moderator/modules/select_card_role/select_card_role.dart';
import '../../modules/modules.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: RouteName.home,
      page: () => HomeView(),
    ),
    GetPage(
      name: RouteName.gameScreen,
      page: () => GameScreenView(),
      binding: GameBinding()
    ),
    GetPage(
        name: RouteName.selectCardRole,
        page: () => SelectCardRoleView(),
        binding: SelectCardRoleBinding()),
  ];
}
