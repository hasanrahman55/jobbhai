import 'package:flutter/material.dart';

import '../theme/colors.dart';

class SelectableButtons extends StatelessWidget {
  List buttonList;
  int selectedIndex;
  SelectableButtons({
    Key? key,
    required this.buttonList,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: buttonList.length,
            itemBuilder: (BuildContext context, int index) {
              return Button(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                title: buttonList[index],
                color: (selectedIndex == index)
                    ? AppColors.primaryColor
                    : Colors.grey.shade200,
                textColor: (selectedIndex == index)
                    ? Colors.white
                    : Colors.grey.shade600,
              );
            },
          );
        },
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String title;
  final Color color;
  final Color textColor;
  final void Function()? onTap;
  const Button({
    Key? key,
    required this.title,
    required this.color,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          // boxShadow: const [BoxShadow(blurStyle: BlurStyle.outer)],
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 16, color: textColor),
          ),
        ),
      ),
    );
  }
}
