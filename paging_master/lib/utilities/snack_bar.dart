import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:paging_master/constants/colors.dart';

void showSnackBar({String title, String message}) {

    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.white,
        duration: Duration(milliseconds: 2000),
        colorText: AppColors.red,
        margin: new EdgeInsets.only(left: 0, right: 0),
        borderColor: AppColors.lightGrey,
        borderWidth: 0.5,
        borderRadius: 0.0);

}

