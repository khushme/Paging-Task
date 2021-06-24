import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paging_master/constants/colors.dart';
import 'package:paging_master/controllers/main_screen_controller.dart';


class MainScreenTile extends StatelessWidget {
  final int index;
  MainScreenTile({@required this.index}) : super(key: UniqueKey());


  final MainScreenController mainScreenController =
      Get.find<MainScreenController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: Row(
          children: [

            CachedNetworkImage(
              imageUrl: mainScreenController.tasks.value.data[index].avatar,
              imageBuilder: (context, imageProvider) => Container(
                width: 90.0,
                height: 90.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              errorWidget: (context, url, error) =>
                  Container(
                    width: 90.0,
                    child: Icon(
                      Icons.error,
                      color: AppColors.darkGrey,
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius:
                        BorderRadius.circular(5)),
                  ),
              placeholder: (context, url) => Container(
                width: 90.0,
                decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius:
                    BorderRadius.circular(5)),
              ),
              height: 90.0,
              width: 90.0,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${mainScreenController.tasks.value.data[index].firstName} ${mainScreenController.tasks.value.data[index].lastName}",
                    style: TextStyle(
                      color: AppColors.black,
                    )),
                SizedBox(height: 10.0),
                Text(mainScreenController.tasks.value.data[index].email,
                    style: TextStyle(
                      color: AppColors.black,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

}
