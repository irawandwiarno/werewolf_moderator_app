import 'package:ww_moderator/modules/game_screen/game_management.dart';
import 'package:ww_moderator/shared/packages.dart';
import 'package:ww_moderator/utils/components/controller/card_role_and_name_controller.dart';

import '../../../exports.dart';

class MyDialog {
  Future showAddName(CardRoleAndNameController controller) {
    return Get.dialog(AlertDialog(
      title: Text(
        'Masukan Nama Player',
        style: MyText.h3(),
      ),
      // content: TextField(controller: textEditingController,),
      actions: <Widget>[
        TextButton(
          child: Text('Batal', style: MyText.title(color: MyColors.varianRed)),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: Text('Save', style: MyText.title(color: MyColors.varianGreen)),
          onPressed: () async {
            // controller.name.value = textEditingController.text;
            Get.back();
          },
        ),
      ],
    ));
  }

  Future displayText({required String title, required VoidCallback onTap}) {
    return Get.dialog(
      GestureDetector(
        onTap: () {
          Get.back();
          onTap();
        },
        child: Card(
          child: Container(
            color: MyColors.defaultWhite,
            width: 800,
            height: 800,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              child: RotatedBox(
                quarterTurns: -1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      title,
                      style: MyText.oversize(),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Tap to close",
                      style: MyText.title(color: MyColors.disable),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void normal(
      {required String title,
      required String subtitle,
      required VoidCallback action,
      bool withBack = true}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: MyText.h3()),
              SizedBox(height: 10),
              Text(
                subtitle,
                style: MyText.subtitle(),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            MyColors.varianRed, // Warna hijau untuk tombol
                      ),
                      child: Text(
                        'Cancel',
                        style: MyText.title(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        action();
                        if (withBack) {
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            MyColors.varianGreen, // Warna hijau untuk tombol
                      ),
                      child: Text(
                        'Yes',
                        style: MyText.title(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
