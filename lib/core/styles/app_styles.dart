import 'package:flutter/cupertino.dart';

class AppStyles {
  static const mainShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(18)),
  );
  static const mainShapeMini = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(9)),
  );

  static const mainBorder = BorderRadius.all(Radius.circular(18));
  static const mainBorderMini = BorderRadius.all(Radius.circular(9));

  static const mainMarding = EdgeInsets.all(14);
  static const mainMardingMini = EdgeInsets.all(7);
  static const quizMarding = EdgeInsets.fromLTRB(9, 9, 9, 13.5);
  static const mainMardingMicro = EdgeInsets.all(3.5);
  static const matchMarding = EdgeInsets.fromLTRB(14, 0, 14, 7);
  static const sortMarding = EdgeInsets.symmetric(horizontal: 14, vertical: 3.5);

  static const mardingWithoutBottom = EdgeInsets.fromLTRB(14, 14, 14, 0);
  static const mardingWithoutBottomMini = EdgeInsets.fromLTRB(7, 7, 7, 0);

  static const mardingWithoutTop = EdgeInsets.fromLTRB(14, 0, 14, 14);
  static const mardingWithoutTopMini = EdgeInsets.fromLTRB(7, 0, 7, 7);

  static const mardingSymmetricHor = EdgeInsets.symmetric(horizontal: 14);
  static const mardingSymmetricHorMini = EdgeInsets.symmetric(horizontal: 7);

  static const mardingSymmetricVer = EdgeInsets.symmetric(vertical: 14);
  static const mardingSymmetricVerMini = EdgeInsets.symmetric(vertical: 7);

  static const mardingOnlyTop = EdgeInsets.only(top: 14);
  static const mardingOnlyTopMini = EdgeInsets.only(top: 7);

  static const mardingOnlyBottom = EdgeInsets.only(bottom: 14);
  static const mardingOnlyBottomMini = EdgeInsets.only(bottom: 7);

  static const mardingOnlyLeft = EdgeInsets.only(left: 14);
  static const mardingOnlyLeftMini = EdgeInsets.only(left: 7);

  static const mardingOnlyRight = EdgeInsets.only(right: 14);
  static const mardingOnlyRightMini = EdgeInsets.only(right: 7);

  static const horizontalVerticalMini = EdgeInsets.symmetric(horizontal: 14, vertical: 7);
  static const horizontalMicroVerticalMicro = EdgeInsets.symmetric(horizontal: 3.5, vertical: 3.5);
  static const verticalHorizontalMini = EdgeInsets.symmetric(horizontal: 7, vertical: 14);

  static const collectionColors = <Color>[
    CupertinoColors.systemBlue,
    CupertinoColors.systemRed,
    CupertinoColors.systemYellow,
    CupertinoColors.systemGreen,
    CupertinoColors.systemOrange,
    CupertinoColors.systemTeal,
    CupertinoColors.systemPurple,
    CupertinoColors.systemIndigo,
  ];
}
