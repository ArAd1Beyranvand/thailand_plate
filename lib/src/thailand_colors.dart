import 'package:flutter/widgets.dart';

/// The colours of the current Thai plates.
///
/// Every reference is a photograph, flattened and colour-balanced by the
/// offline stage, so each value is the measured field or ink of the photo
/// named beside it, not a reading of the article's adjectives. Its table
/// leaves most ink colours blank.
abstract final class ThailandColors {
  /// Private field. `License_plate_of_Thailand_003`: `F1F1F4`. Also used for
  /// the private truck and the motorcycle, whose photos are lit too dimly or
  /// too blue to give a white (`AEADAB`, `D5DDEF`).
  static const Color white = Color(0xFFF1F1F4);

  /// Private ink, same photo: `1D1B1F`. Also the private truck's and the
  /// motorcycle's (`191818`, `1F2139` in their own photos).
  static const Color black = Color(0xFF1D1B1F);

  /// Van field. `Blue_on_white_license_plate_Thailand_02`: `ECE9E4`.
  static const Color vanField = Color(0xFFECE9E4);

  /// Van ink, same photo: `205CB9`.
  static const Color blue = Color(0xFF205CB9);

  /// Pick-up field. `Green_on_white_Thailand_license_plate_02`: `E7E8E6`.
  static const Color pickupField = Color(0xFFE7E8E6);

  /// Pick-up ink, same photo: `23593D`.
  static const Color green = Color(0xFF23593D);

  /// Tricycle field. `Red_on_white_license_plate_Thailand`: `D2D2D3`.
  static const Color tricycleField = Color(0xFFD2D2D3);

  /// Tricycle ink, same photo: `75251B`.
  static const Color red = Color(0xFF75251B);

  /// Trailer field. `Thai_trailer_plate`: `DD7143`.
  static const Color orange = Color(0xFFDD7143);

  /// Trailer ink, same photo: `3D3937`.
  static const Color charcoal = Color(0xFF3D3937);

  /// Taxi field. `Thai_taxi_licence_plate`: `E6AD02`.
  static const Color taxiYellow = Color(0xFFE6AD02);

  /// Taxi ink, same photo: `575432`.
  static const Color taxiInk = Color(0xFF575432);

  /// Tuk-tuk field. `Thai_tuk-tuk_taxi_licence_plate`: `FFAD34`.
  static const Color amber = Color(0xFFFFAD34);

  /// Tuk-tuk ink, same photo: `447E5F`.
  static const Color tukTukGreen = Color(0xFF447E5F);

  /// Service-vehicle field. `White_on_green_license_plate_Thailand_03`:
  /// `5BC0BC`, the article's "aquamarine".
  static const Color aquamarine = Color(0xFF5BC0BC);

  /// Service-vehicle ink, same photo: `F6F4F6`.
  static const Color offWhite = Color(0xFFF6F4F6);

  /// Trade-plate field. `TargaThai_NeroSuRosso`: `FF5670`.
  static const Color tradeRed = Color(0xFFFF5670);

  /// Trade-plate ink, same photo: `52475C`.
  static const Color tradeInk = Color(0xFF52475C);

  /// Hired truck field. `Licenceplate_Thailand`: `F6D23D`.
  static const Color truckYellow = Color(0xFFF6D23D);

  /// Hired truck ink, same photo: `746B5B`.
  static const Color truckInk = Color(0xFF746B5B);

  static const Color inactive = Color(0xFFB0B0B0);
}
