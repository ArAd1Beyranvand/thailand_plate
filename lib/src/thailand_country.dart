import 'package:plate_core/plate_core.dart';

import 'thailand_colors.dart';

/// No flag or country block (the province is printed on the face), so every
/// spec sets `noPanel`.
abstract final class ThailandCountry {
  static const PlateCountry thailand = PlateCountry(
    code: 'th',
    captionLines: <String>[],
    panelColor: ThailandColors.white,
    panelTextColor: ThailandColors.black,
  );
}
