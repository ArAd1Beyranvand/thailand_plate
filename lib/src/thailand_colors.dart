import 'package:flutter/widgets.dart';

/// Field and ink measured from flattened, colour-balanced reference photos
/// (the article leaves most inks blank). The private truck and motorcycle
/// reuse [white] and [black] because their photos are lit too dimly or too
/// blue to give a white.
abstract final class ThailandColors {
  static const Color white = Color(0xFFF1F1F4);
  static const Color black = Color(0xFF1D1B1F);
  static const Color vanField = Color(0xFFECE9E4);
  static const Color blue = Color(0xFF205CB9);
  static const Color pickupField = Color(0xFFE7E8E6);
  static const Color green = Color(0xFF23593D);
  static const Color tricycleField = Color(0xFFD2D2D3);
  static const Color red = Color(0xFF75251B);
  static const Color orange = Color(0xFFDD7143);
  static const Color charcoal = Color(0xFF3D3937);
  static const Color taxiYellow = Color(0xFFE6AD02);
  static const Color taxiInk = Color(0xFF575432);
  static const Color amber = Color(0xFFFFAD34);
  static const Color tukTukGreen = Color(0xFF447E5F);
  static const Color aquamarine = Color(0xFF5BC0BC);
  static const Color offWhite = Color(0xFFF6F4F6);
  static const Color tradeRed = Color(0xFFFF5670);
  static const Color tradeInk = Color(0xFF52475C);
  static const Color truckYellow = Color(0xFFF6D23D);
  static const Color truckInk = Color(0xFF746B5B);
  static const Color inactive = Color(0xFFB0B0B0);
}
