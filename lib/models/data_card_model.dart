import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/shared/shared.dart';

class DataCard {
  final int id;
  final String roleName;
  final String description;
  final String image;
  String? subRole;

  String playerName = 'Tidak tau';


  DataCard({
    required this.id,
    required this.roleName,
    required this.description,
    required this.image,
  });

}
