import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../../theme/colors.dart';

class SeeMoreText extends StatefulWidget {
  final String text;

  const SeeMoreText({Key? key, required this.text}) : super(key: key);

  @override
  SeeMoreTextState createState() => SeeMoreTextState();
}

class SeeMoreTextState extends State<SeeMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<String> textList = widget.text.split(' ');
    String displayedText = '';

    if (!_isExpanded) {
      for (int i = 0; i < (textList.length > 50 ? 50 : textList.length); i++) {
        displayedText += '${textList[i]} ';
      }
    } else {
      displayedText = widget.text;
    }

    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: displayedText,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 15),
          ),
          if (textList.length > 50)
            TextSpan(
              text: _isExpanded ? ' See less' : ' See more',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 15, color: AppColors.primaryColor),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
            ),
        ],
      ),
    );
  }
}
