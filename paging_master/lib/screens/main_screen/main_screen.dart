import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paging_master/common_widgets/progressbar.dart';
import 'package:paging_master/constants/colors.dart';
import 'package:paging_master/constants/strings/strings.dart';
import 'package:paging_master/controllers/main_screen_controller.dart';
import 'package:paging_master/screens/main_screen/main_screen_tile.dart';
import 'package:paging_master/utilities/snack_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
// Initialise main screen GetX controller
  final MainScreenController mainScreenController =
      Get.put(MainScreenController());

  //Initialise controller to handle data list scrolling
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _setScrollListener();
  }

  void _setScrollListener() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          if (mainScreenController.page < 3) {
            mainScreenController.page++;
            mainScreenController.bottomLoading.value = true;
            mainScreenController.fetchList();

          }
          else
            showSnackBar(message: StringConstants.noMoreItems);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(StringConstants.mainScreenAppBar),
        ),
        body: Obx(() => mainScreenController.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Container(
                      color: AppColors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                          StringConstants.itemCount +
                              mainScreenController.tasks.value.data.length
                                  .toString(),
                          style: TextStyle(
                            color: AppColors.black,
                          )),
                    ),
                    Expanded(
                        child: ListView.builder(
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return MainScreenTile(index: index);
                            },
                            itemCount:
                                mainScreenController.tasks.value.data.length)),
                    mainScreenController.bottomLoading.value
                        ? pagingLoader()
                        : Container()
                  ]))));
  }
}
