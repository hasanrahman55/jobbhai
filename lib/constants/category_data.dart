import 'package:flutter/material.dart';

import '../model/category.dart';
import 'app_svg.dart';

const categoryData = [
  Category(
      category: "Design", icon: AppSvg.brushBold, iconColor: Colors.blueGrey),
  Category(
      category: "Software",
      icon: AppSvg.codeCircleBold,
      iconColor: Colors.teal),
  Category(
      category: "Data",
      icon: AppSvg.cpuChargeBold,
      iconColor: Colors.lightGreen),
  Category(
      category: "Marketing",
      icon: AppSvg.statusUpBold,
      iconColor: Colors.indigo),
  Category(category: "Data", icon: AppSvg.commandBold, iconColor: Colors.pink),
  Category(
      category: "Research",
      icon: AppSvg.microscopeBold,
      iconColor: Colors.cyan),
  Category(
      category: "Teaching",
      icon: AppSvg.awardBold,
      iconColor: Colors.deepPurple),
  Category(
      category: "Engineering",
      icon: AppSvg.bezierBold,
      iconColor: Colors.deepOrange),
];
