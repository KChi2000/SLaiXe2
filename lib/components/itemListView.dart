import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class itemListView extends StatelessWidget {
  const itemListView({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.color,
    @required this.underline,
  }) : super(key: key);

  final String title;
  final String icon;
  final Color color;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 24, height: 24),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(title,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: color,
                  fontFamily: 'Roboto Medium',
                  fontSize: 14,
                  decoration: underline
                      ? TextDecoration.underline
                      : TextDecoration.none)),
        ),
      ],
    );
  }
}
