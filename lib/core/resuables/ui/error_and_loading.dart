import 'package:flutter/material.dart';

Widget errorWidget(Object error,  StackTrace stackTrace){
  return  Center(child: Text(error.toString()),);
}
Widget loading()=>const Center(child: CircularProgressIndicator(),);