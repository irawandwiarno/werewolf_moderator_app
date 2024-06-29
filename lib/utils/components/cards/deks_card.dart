import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/config/themes/colors.dart';
import 'package:ww_moderator/exports.dart';
import 'package:ww_moderator/models/data_card_model.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/buttons/my_button_icon.dart';
import 'package:ww_moderator/utils/components/cards/card.dart';
import 'package:ww_moderator/utils/components/controller/deks_card_controller.dart';
import 'package:ww_moderator/utils/components/controller/timer_controller.dart';
import 'package:ww_moderator/utils/controler/role_controller/role_controller.dart';

class DeksCard extends GetView<DeksCardController> {
  DeksCard({
    super.key,
    required this.screenWidth,
    required this.deks,
  });

  final double screenWidth;
  final List<BaseRole> deks;

  TimerCountDownController timerController =
      Get.find<TimerCountDownController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: 160,
      decoration: BoxDecoration(
        color: MyColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColors.outline, width: 4),
      ),
      child: Row(
        children: [
          Expanded(
            child: ListCardRole(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: screenWidth / 5,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              color: MyColors.backgroundApp,
            ),
            child: Center(
              child: Column(
                children: [
                  MyButtonIcon(
                    onPressed: () => controller.prevButton(),
                    icon: Icons.arrow_back_ios_new_rounded,
                  ),
                  MyButtonIcon(
                    onPressed: () => controller.nextButton(),
                    icon: Icons.arrow_forward_ios_rounded,
                  ),
                  MyButtonIcon(
                    onPressed: () => controller.goMorning(),
                    icon: Icons.sunny,
                    color: MyColors.varianBlue,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ListCardRole() {
    return ListView.builder(
        controller: controller.scrollController,
        shrinkWrap: true,
        itemCount: deks.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemBuilder: (context, index) => CardPlayerRole(indexOfCard: index));
  }
}
