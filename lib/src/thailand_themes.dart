import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'thailand_colors.dart';

/// One ink on one field, the frame in the ink. Frame widths are not measured:
/// the flattened photos show a clear outline only on the service-vehicle,
/// tuk-tuk and truck plates, so the rest print a hairline.
abstract final class ThailandThemes {
  static final PlateTheme private = _ink(
    ThailandColors.white,
    ThailandColors.black,
  );

  static final PlateTheme van = _ink(
    ThailandColors.vanField,
    ThailandColors.blue,
  );

  static final PlateTheme pickup = _ink(
    ThailandColors.pickupField,
    ThailandColors.green,
  );

  static final PlateTheme tricycle = _ink(
    ThailandColors.tricycleField,
    ThailandColors.red,
  );

  static final PlateTheme trailer = _ink(
    ThailandColors.orange,
    ThailandColors.charcoal,
  );

  static final PlateTheme taxi = _ink(
    ThailandColors.taxiYellow,
    ThailandColors.taxiInk,
  );

  static final PlateTheme tukTuk = _ink(
    ThailandColors.amber,
    ThailandColors.tukTukGreen,
    framed: true,
  );

  static final PlateTheme tourist = _ink(
    ThailandColors.aquamarine,
    ThailandColors.offWhite,
    framed: true,
  );

  static final PlateTheme trade = _ink(
    ThailandColors.tradeRed,
    ThailandColors.tradeInk,
  );

  static final PlateTheme motorcycle = _ink(
    ThailandColors.white,
    ThailandColors.black,
  );

  static final PlateTheme truckPrivate = _ink(
    ThailandColors.white,
    ThailandColors.black,
    framed: true,
  );

  static final PlateTheme truckHired = _ink(
    ThailandColors.truckYellow,
    ThailandColors.truckInk,
    framed: true,
  );
}

PlateTheme _ink(Color field, Color ink, {bool framed = false}) =>
    PlateTheme.monochrome(
      field: field,
      ink: ink,
      inactive: ThailandColors.inactive,
      borderWidthRatio: framed ? 0.02 : 0.008,
      plateRadiusRatio: 0.05,
    );
