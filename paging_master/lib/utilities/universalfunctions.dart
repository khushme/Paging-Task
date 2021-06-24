import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paging_master/constants/colors.dart';
import 'package:paging_master/constants/strings/strings.dart';


bool alertAlreadyActive = false;

// Check internet connection availability
Future<bool> hasInternetConnection({
  @required BuildContext context,
  @required Function onSuccess,
  @required Function onFail,
  bool canShowAlert = true,
}) async {
  if (!kIsWeb) {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        onSuccess();
        return true;
      } else {
        if (canShowAlert) {
          onFail();
          showAlert(
            context: context,
            titleText: StringConstants.error,
            message: StringConstants.noInternetError,
            actionCallbacks: {
              StringConstants.ok: () {
                return false;
              }
            },
          );
        }
      }
    } catch (_) {
      onFail();
      showAlert(
          context: context,
          titleText: StringConstants.error,
          message: StringConstants.noInternetError,
          actionCallbacks: {
            StringConstants.ok: () {
              return false;
            }
          });
    }
    return false;
  } else {
    return true;
  }
}


// Show alert dialog
void showAlert(
    {@required BuildContext context,
      String titleText,
      Widget title,
      String message,
      Widget content,
      Map<String, VoidCallback> actionCallbacks}) {
  Widget titleWidget = titleText == null
      ? title
      : new Text(
    titleText.toUpperCase(),
    textAlign: TextAlign.center,
    style: new TextStyle(
      color: AppColors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
  );
  Widget contentWidget = message == null
      ? content != null
      ? content
      : new Container()
      : new Text(
    message,
    textAlign: TextAlign.center,
    style: new TextStyle(
      color: AppColors.black,
      fontWeight: FontWeight.w500,
//            fontFamily: Constants.contentFontFamily,
    ),
  );

  OverlayEntry alertDialog;
  // Returns alert actions
  List<Widget> _getAlertActions(Map<String, VoidCallback> actionCallbacks) {
    List<Widget> actions = [];
    actionCallbacks.forEach((String title, VoidCallback action) {
      actions.add(
        new ButtonTheme(
          minWidth: 0.0,
          child: new CupertinoDialogAction(
            child: new Text(title,
                style: new TextStyle(
                  color: AppColors.black,
                  fontSize: 16.0,
//                        fontFamily: Constants.contentFontFamily,
                )),
            onPressed: () {
              action();
              alertDialog?.remove();
              alertAlreadyActive = false;
            },
          ),

        ),
      );
    });
    return actions;
  }

  List<Widget> actions =
  actionCallbacks != null ? _getAlertActions(actionCallbacks) : [];

  OverlayState overlayState;
  overlayState = Overlay.of(context);

  alertDialog = new OverlayEntry(builder: (BuildContext context) {
    return new Positioned.fill(
      child: new Container(
        color: Colors.black.withOpacity(0.7),
        alignment: Alignment.center,
        child: new WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: new Dialog(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: new Material(
              borderRadius: new BorderRadius.circular(10.0),
              color: AppColors.white,
              child: new Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                            ),
                            child: titleWidget,
                          ),
                          contentWidget,
                        ],
                      ),
                    ),
                    new Container(
                      height: 0.6,
                      margin: new EdgeInsets.only(
                        top: 24.0,
                      ),
                      color: AppColors.black,
                    ),
                    new Row(
                      children: <Widget>[]..addAll(
                        new List.generate(
                          actions.length +
                              (actions.length > 1 ? (actions.length - 1) : 0),
                              (int index) {
                            return index.isOdd
                                ? new Container(
                              width: 0.6,
                              height: 30.0,
                              color: AppColors.black,
                            )
                                : new Expanded(
                              child: actions[index ~/ 2],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  });

  if (!alertAlreadyActive) {
    alertAlreadyActive = true;
    overlayState.insert(alertDialog);
  }
}
