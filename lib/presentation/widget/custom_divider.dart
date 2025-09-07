import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

Widget customDivider({bool hasTopMargin = true, bool hasBottomMargin = true}) {
  double topMargin = hasTopMargin ? 10 : 0;
  double bottomMargin = hasBottomMargin ? 10 : 0;

  return Container(
    color: SftColors.lightGreen.withValues(alpha: 0.2),
    height: 1,
    margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
  );
}