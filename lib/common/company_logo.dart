import 'package:flutter/material.dart';

class CompanyLogo extends StatelessWidget {
  final String imageUrl;
  final double size;
  const CompanyLogo({
    Key? key,
    required this.imageUrl,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size + 10,
      width: size + 10,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              blurStyle: BlurStyle.outer,
              blurRadius: 1)
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.network(
        // color: Colors.transparent,
        fit: BoxFit.contain,
        imageUrl,
        height: size,
        width: size,
      ),
    );
  }
}
