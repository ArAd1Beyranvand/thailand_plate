import 'package:flutter/foundation.dart';

/// The three layouts a category is printed in; closed, as the library owns
/// them.
enum ThailandDesign {
  /// Series letters and up to four digits over the province: the 15 × 34 cm
  /// plate of cars, vans, pick-ups, tricycles, trailers and taxis.
  standard,

  /// Three rows: series, province, serial. The 17.2 × 22 cm motorcycle plate.
  motorcycle,

  /// `THAILAND` and a province code over two digits, a dash and four digits,
  /// the province and the ขส seal beneath. The 22 × 44 cm bus and truck plate.
  truck,
}

/// A plate category: its design and the few things that vary within one.
@immutable
class ThailandCategory {
  const ThailandCategory._(
    this.id,
    this.name,
    this.design, {
    this.seriesLetters = 2,
    this.dash = false,
  });

  /// Stable identifier, used in spec ids.
  final String id;

  final String name;

  final ThailandDesign design;

  /// How many series letters the plate prints (standard design only).
  final int seriesLetters;

  /// Whether a dash separates the series from the serial.
  final bool dash;

  /// Whether a digit may lead the series, as in Bangkok's `1กข 1234`.
  bool get allowsLeadingDigit => design == ThailandDesign.standard && !dash;

  static const ThailandCategory private = ThailandCategory._(
    'private',
    'Private cars and 4-door pick-ups',
    ThailandDesign.standard,
  );
  static const ThailandCategory van = ThailandCategory._(
    'van',
    'Private vans',
    ThailandDesign.standard,
  );
  static const ThailandCategory pickup = ThailandCategory._(
    'pickup',
    'Private 2-door pick-ups',
    ThailandDesign.standard,
  );
  static const ThailandCategory tricycle = ThailandCategory._(
    'tricycle',
    'Private motorized tricycles',
    ThailandDesign.standard,
  );
  static const ThailandCategory trailer = ThailandCategory._(
    'trailer',
    'Trailers, road rollers, tractors and agricultural vehicles',
    ThailandDesign.standard,
  );
  static const ThailandCategory taxi = ThailandCategory._(
    'taxi',
    'Car taxis',
    ThailandDesign.standard,
  );
  static const ThailandCategory tukTuk = ThailandCategory._(
    'tuk_tuk',
    'Motorized tricycle taxis (tuk-tuks)',
    ThailandDesign.standard,
  );
  static const ThailandCategory tourist = ThailandCategory._(
    'tourist',
    'Business, tourist and rental-service vehicles',
    ThailandDesign.standard,
  );
  static const ThailandCategory trade = ThailandCategory._(
    'trade',
    'Trade (temporary)',
    ThailandDesign.standard,
    seriesLetters: 1,
    dash: true,
  );
  static const ThailandCategory motorcycle = ThailandCategory._(
    'motorcycle',
    'Private motorcycles',
    ThailandDesign.motorcycle,
    seriesLetters: 3,
  );
  static const ThailandCategory truckPrivate = ThailandCategory._(
    'truck_private',
    'Private buses and trucks',
    ThailandDesign.truck,
    dash: true,
  );
  static const ThailandCategory truckHired = ThailandCategory._(
    'truck_hired',
    'Hired buses and trucks',
    ThailandDesign.truck,
    dash: true,
  );

  static const List<ThailandCategory> values = <ThailandCategory>[
    private,
    van,
    pickup,
    tricycle,
    trailer,
    taxi,
    tukTuk,
    tourist,
    trade,
    motorcycle,
    truckPrivate,
    truckHired,
  ];
}
