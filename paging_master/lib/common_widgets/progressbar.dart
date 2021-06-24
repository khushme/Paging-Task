import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// Loader to show at bottom of screen
pagingLoader() {
  return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 30,
          width: 30,
          child:  CircularProgressIndicator(),
        ),
      ));
}