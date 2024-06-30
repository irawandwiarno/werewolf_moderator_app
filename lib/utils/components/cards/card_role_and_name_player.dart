import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ww_moderator/config/config.dart';
import 'package:ww_moderator/config/themes/themes.dart';
import 'package:ww_moderator/exports.dart';
import 'package:ww_moderator/models/data_card_model.dart';
import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/buttons/my_button_icon.dart';
import 'package:ww_moderator/utils/components/controller/card_role_and_name_controller.dart';

class CardRoleAndNamePlayer extends StatelessWidget {
  CardRoleAndNamePlayer({
    super.key,
    required this.screenWidth,
    required this.tagController,
    required this.indexOfCard,
  });

  final String tagController;
  final double screenWidth;
  final int indexOfCard;

  @override
  Widget build(BuildContext context) {
    final CardRoleAndNameController controller = Get.put(
      CardRoleAndNameController(indexOfCard: indexOfCard),
      tag: tagController,
    );

    return GestureDetector(
      onTap: () {
        print('=== $tagController');
        controller.onChoose(indexChoosedCard: indexOfCard);
      },
      child: Obx(() => Container(
            margin: const EdgeInsets.only(bottom: 5),
            height: 100,
            width: screenWidth,
            decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: controller.dataPlayer!.isChoose.value
                        ? MyColors.varianGreen
                        : MyColors.outline,
                    width: 4)),
            child: Row(
              children: [
                conditionPlayer(controller: controller),
                DisplayNameAndRole(controller),
                EditNameButton(controller)
              ],
            ),
          )),
    );
  }

  Widget conditionPlayer({required CardRoleAndNameController controller}) {
    return Obx(() => conditionFlag(controller));
  }

  Widget conditionFlag(CardRoleAndNameController controller) {
    if (controller.dataPlayer!.isDead.value) {
      return deadFlag(controller);
    }

    if (controller.gameManagement.voteTime.value) {
      return voteContainer(controller);
    }

    if (controller.dataPlayer!.isSilent.value) {
      return silentFlag(controller);
    }

    if (controller.dataPlayer!.isProtected.value) {
      return protectedFlag(controller);
    }

    if (controller.dataPlayer!.isKill.value) {
      return killFlag(controller);
    }

    return netralFlag(controller);
  }

  Widget killFlag(CardRoleAndNameController controller) {
    return Container(
      width: 60,
      height: 100,
      decoration: const BoxDecoration(
          color: MyColors.varianRed,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
      child: const Icon(
        Icons.close_rounded,
        size: 50,
        color: MyColors.outline,
      ),
    );
  }

  Widget deadFlag(CardRoleAndNameController controller) {
    return Container(
      width: 60,
      height: 100,
      decoration: const BoxDecoration(
          color: MyColors.disable,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
      child: const Icon(
        Icons.close_rounded,
        size: 50,
        color: MyColors.outline,
      ),
    );
  }

  Widget protectedFlag(CardRoleAndNameController controller) {
    return Container(
      width: 60,
      height: 100,
      decoration: const BoxDecoration(
          color: MyColors.varianBlue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
      child: const Icon(
        Icons.shield,
        size: 40,
        color: MyColors.outline,
      ),
    );
  }

  Widget silentFlag(CardRoleAndNameController controller) {
    return Container(
      width: 60,
      height: 100,
      decoration: const BoxDecoration(
          color: MyColors.varianGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
      child: const Icon(
        Icons.do_not_disturb_on_total_silence_outlined,
        size: 50,
        color: MyColors.outline,
      ),
    );
  }

  Widget netralFlag(CardRoleAndNameController controller) {
    return Container(
      width: 60,
      height: 100,
      decoration: const BoxDecoration(
          color: MyColors.transparan,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
    );
  }

  Widget voteContainer(CardRoleAndNameController controller) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
          color: MyColors.transparan,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))),
      child: Row(
        children: [
          Column(
            children: [
              MyButtonIcon(
                onPressed: () => controller.plusAction(),
                icon: Icons.add,
                size: 20,
                height: 40,
              ),
              SizedBox(
                height: 5,
              ),
              MyButtonIcon(
                onPressed: () => controller.minusAction(),
                icon: Icons.remove,
                size: 20,
                height: 40,
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Obx(
            () => Text(
              "${controller.dataPlayer!.voteCount.value}",
              style: MyText.h3(color: MyColors.outline),
            ),
          )
        ],
      ),
    );
  }

  Expanded DisplayNameAndRole(CardRoleAndNameController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => controller.isEditName.value
                ? TextField(
                    controller: controller.textEditingController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    autocorrect: true,
                    style: MyText.h3(color: MyColors.varianBlue),
                  )
                : Text(
                    controller.dataPlayer!.dataCard.playerName,
                    style: MyText.h3(color: MyColors.varianBlue),
                  )),
            Text(
              controller.dataPlayer!.dataCard.roleName,
              style: MyText.title(color: MyColors.outline),
            ),
          ],
        ),
      ),
    );
  }

  Container EditNameButton(CardRoleAndNameController controller) {
    return Container(
      child: Obx(
        () => controller.isEditName.value
            ? Column(
                children: [
                  CancelButton(controller),
                  SaveButton(controller),
                ],
              )
            : IconButton(
                onPressed: () => controller.onPressedIconButon(),
                icon: const Icon(Icons.edit_outlined)),
      ),
    );
  }

  Expanded SaveButton(CardRoleAndNameController controller) => Expanded(
          child: IconButton(
        onPressed: () => controller.saveAction(),
        icon: const Icon(Icons.check),
        color: MyColors.varianGreen,
      ));

  Expanded CancelButton(CardRoleAndNameController controller) => Expanded(
          child: IconButton(
        onPressed: () => controller.cancelAction(),
        icon: const Icon(Icons.close_rounded),
        color: MyColors.redDead,
      ));
}
