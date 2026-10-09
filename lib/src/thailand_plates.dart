import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'thailand_country.dart';
import 'thailand_provinces.dart';
import 'thailand_themes.dart';
import 'thailand_usage.dart';

/// Where the ink sits on the current Thai plates, in plate units.
///
/// Every reference is a photograph, flattened to 600×264 by the offline stage
/// (platekit `photos`: 150 × 66 brief units, every plate squeezed to one
/// aspect) and measured by projecting the ink onto each axis. A brief unit
/// becomes a plate unit by the factor of the real plate: the 15 × 34 cm plate
/// is 340 × 150 (×2.267 in x, ×2.273 in y), the 17.2 × 22 cm motorcycle plate
/// 220 × 172 (×1.467, ×2.606) and the 22 × 44 cm truck plate 440 × 220
/// (×2.933, ×3.333).
///
/// Measured ink, as target for the goldens:
///
/// * Standard (`License_plate_of_Thailand_003`): serial row y 15.4–80.5
///   (cy 48), letters x 36–127, digits x 168–325, province y 108–134 and
///   centred on x 170. A leading digit (`Green_on_white…_02`, `2ฒย 3201`)
///   sits at x 16–50, its two letters at x 60–165 and the digits from x 171.
/// * Trade (`TargaThai_NeroSuRosso`): letter x 35–70, dash x 79–111, digits
///   x 129–307, row y 10–97, province y 120–139.
/// * Motorcycle (`TargaMotoRayong`): series y 19.5–62 over x 52–164, province
///   y 82–104, serial y 117–160 over x 53–164.
/// * Truck (`Licenceplate_Thailand`): `THAILAND` x 110–340, y 15–42, the
///   code x 364–405; serial y 53–150, `70` x 32–135, dash x 139–167, digits
///   x 180–411; province y 173–196 and the seal at x 33–58.
///
/// Rows are limited by the canvas, not by the measurement. The standard
/// reference's serial is 65 high, which wants a 118 box on a 150 plate whose
/// serial centre is 48: the box is held to 96, so the ink is ~80% of the
/// reference. The truck's digits are held to a 150 box because the 58 pitch
/// squeezes anything taller. Photos of the private truck, the motorcycle and
/// the trailer are lit or fitted poorly: the trailer's digits end at x 257
/// where the standard's end at 325; the standard layout is used for it.
///
/// Not implemented: the pictorial plate (`Chiang_Mai_auction…`, a printed
/// artwork, not a layout), the inter-province taxi plate, the hired
/// motorcycle, the diplomatic plate (11 × 38.7 cm, `ท 01 - 1234`), the
/// royal, police and military plates and the international-travel plate: the
/// article gives each in words and no photograph to measure. The tax-paid
/// label is a windshield sticker. No flag is printed on any photographed
/// plate, so no icon is placed. The article lists nothing Israel-specific.
abstract final class _Layout {
  // Standard plate, 15 × 34 cm.
  static const double width = 340, height = 150;
  static const double serialCy = 48, serialBox = 96;
  static const double letterPitch = 45.3, lettersCx = 59;
  static const double leadCx = 33, leadPitch = 34;
  static const double ledLettersCx = 86, ledLettersPitch = 52.5;
  static const double digitsCx = 188.4, digitPitch = 38.8;
  static const double provinceCx = 170, provinceCy = 121;
  static const double provinceGlyph = 44, provinceWidth = 280;

  // Trade plate: one letter, a dash, four digits; taller row, lower province.
  static const double tradeCy = 53, tradeBox = 106;
  static const double tradeLetterCx = 52, tradePitch = 35;
  static const double tradeDashCx = 95;
  static const double tradeDigitsCx = 151, tradeDigitPitch = 44.5;
  static const double tradeProvinceCx = 167, tradeProvinceCy = 129;
  static const double tradeProvinceGlyph = 36;

  // Motorcycle plate, 17.2 × 22 cm.
  static const double bikeWidth = 220, bikeHeight = 172;
  static const double bikePitch = 37, bikeCx = 108;
  static const double bikeSeriesCy = 41, bikeSerialCy = 138, bikeBox = 77;
  static const double bikeProvinceCy = 93, bikeProvinceGlyph = 40;

  // Truck plate, 22 × 44 cm.
  static const double truckWidth = 440, truckHeight = 220;
  static const double truckCaptionCy = 28, truckCaptionGlyph = 48;
  static const double truckCaptionCx = 225, truckCaptionWidth = 260;
  static const double truckCodeCx = 374, truckCodePitch = 21, truckCodeBox = 52;
  static const double truckSerialCy = 101, truckSerialBox = 150;
  static const double truckPitch = 57.8;
  static const double truckPrefixCx = 54.8, truckDashCx = 153;
  static const double truckSerialCx = 209.3;
  static const double truckProvinceCx = 222, truckProvinceCy = 185;
  static const double truckProvinceGlyph = 40;
  static const double truckSealCx = 45, truckSealGlyph = 34;
}

/// Accumulates one spec's slots, groups and printed marks.
class _Builder {
  final List<PlateSlot> slots = <PlateSlot>[];
  final List<PlateTextGroup> groups = <PlateTextGroup>[];
  final List<PlateLabel> labels = <PlateLabel>[];

  /// [count] cells centred from [firstCx] at [pitch], [box] tall about [cy].
  void run(
    String key,
    PlateAlphabet alphabet,
    int count,
    double firstCx,
    double pitch,
    double cy,
    double box,
  ) {
    final start = slots.length;
    slots.addAll(
      plateRegister(
        alphabet: alphabet,
        count: count,
        left: firstCx - pitch / 2,
        top: cy - box / 2,
        width: pitch,
        height: box,
      ),
    );
    groups.add(
      PlateTextGroup(<int>[
        for (var i = start; i < slots.length; i++) i,
      ], key: key),
    );
  }

  /// Printed text centred on ([cx], [cy]).
  void text(
    String text,
    double cx,
    double cy,
    double width,
    double height,
    double glyph,
  ) => labels.add(
    PlateLabel(
      text: text,
      box: PlateBox(cx - width / 2, cy - height / 2, width, height),
      glyphHeight: glyph,
    ),
  );
}

/// Thailand's licence plates: three designs, twelve categories.
///
/// * Standard — series letters and up to four digits, the province beneath.
///   Groups `lead` (one digit, Bangkok's `1กข 1234`; only with
///   `leadingDigit`), `series`, `serial`. The trade plate has one series
///   letter and a dash.
/// * Motorcycle — three rows. Groups `series` (three letters), `serial`.
/// * Truck — `THAILAND` and a province `code` over `prefix` (two digits), a
///   dash and `serial` (four digits), the province and the ขส seal beneath.
///
/// Pair each with its theme in [themeOf].
abstract final class ThailandPlates {
  static final Map<String, PlateSpec> _cache = <String, PlateSpec>{};

  /// [province] is printed under every number. [leadingDigit] adds the digit
  /// before the series on the standard plates that allow one.
  static PlateSpec of(
    ThailandCategory category, {
    ThailandProvince province = ThailandProvince.bangkok,
    bool leadingDigit = false,
  }) {
    final lead = leadingDigit && category.allowsLeadingDigit;
    final id = 'th.${category.id}.${province.id}${lead ? '.lead' : ''}';
    return _cache[id] ??= switch (category.design) {
      ThailandDesign.standard => _standard(id, category, province, lead),
      ThailandDesign.motorcycle => _motorcycle(id, category, province),
      ThailandDesign.truck => _truck(id, province),
    };
  }

  static PlateTheme themeOf(ThailandCategory category) => switch (category.id) {
    'private' => ThailandThemes.private,
    'van' => ThailandThemes.van,
    'pickup' => ThailandThemes.pickup,
    'tricycle' => ThailandThemes.tricycle,
    'trailer' => ThailandThemes.trailer,
    'taxi' => ThailandThemes.taxi,
    'tuk_tuk' => ThailandThemes.tukTuk,
    'tourist' => ThailandThemes.tourist,
    'trade' => ThailandThemes.trade,
    'motorcycle' => ThailandThemes.motorcycle,
    'truck_private' => ThailandThemes.truckPrivate,
    _ => ThailandThemes.truckHired,
  };

  static PlateSpec get private => of(ThailandCategory.private);
  static PlateSpec get van => of(ThailandCategory.van);
  static PlateSpec get pickup => of(ThailandCategory.pickup);
  static PlateSpec get tricycle => of(ThailandCategory.tricycle);
  static PlateSpec get trailer => of(ThailandCategory.trailer);
  static PlateSpec get taxi => of(ThailandCategory.taxi);
  static PlateSpec get tukTuk => of(ThailandCategory.tukTuk);
  static PlateSpec get tourist => of(ThailandCategory.tourist);
  static PlateSpec get trade => of(ThailandCategory.trade);
  static PlateSpec get motorcycle => of(ThailandCategory.motorcycle);
  static PlateSpec get truckPrivate => of(ThailandCategory.truckPrivate);
  static PlateSpec get truckHired => of(ThailandCategory.truckHired);

  /// Every category, registered in Bangkok.
  static List<PlateSpec> get all => <PlateSpec>[
    for (final c in ThailandCategory.values) of(c),
  ];

  static PlateSpec _spec(String id, _Builder b, double width, double height) =>
      PlateSpec(
        id: id,
        country: ThailandCountry.thailand,
        canvasWidth: width,
        canvasHeight: height,
        panel: const PlatePanel(box: PlateBox(0, 0, 0, 0)),
        noPanel: true,
        slots: b.slots,
        labels: b.labels,
        textGroups: b.groups,
      );

  static PlateSpec _standard(
    String id,
    ThailandCategory category,
    ThailandProvince province,
    bool lead,
  ) {
    final trade = category == ThailandCategory.trade;
    final cy = trade ? _Layout.tradeCy : _Layout.serialCy;
    final box = trade ? _Layout.tradeBox : _Layout.serialBox;
    final b = _Builder();
    if (lead) {
      b.run(
        'lead',
        ThailandAlphabets.digits,
        1,
        _Layout.leadCx,
        _Layout.leadPitch,
        cy,
        box,
      );
    }
    b.run(
      'series',
      ThailandAlphabets.letters,
      category.seriesLetters,
      trade
          ? _Layout.tradeLetterCx
          : (lead ? _Layout.ledLettersCx : _Layout.lettersCx),
      trade
          ? _Layout.tradePitch
          : (lead ? _Layout.ledLettersPitch : _Layout.letterPitch),
      cy,
      box,
    );
    b.run(
      'serial',
      ThailandAlphabets.digits,
      4,
      trade ? _Layout.tradeDigitsCx : _Layout.digitsCx,
      trade ? _Layout.tradeDigitPitch : _Layout.digitPitch,
      cy,
      box,
    );
    if (category.dash) {
      b.text('-', _Layout.tradeDashCx, cy, 40, box, box);
    }
    b.text(
      province.thai,
      trade ? _Layout.tradeProvinceCx : _Layout.provinceCx,
      trade ? _Layout.tradeProvinceCy : _Layout.provinceCy,
      _Layout.provinceWidth,
      56,
      trade ? _Layout.tradeProvinceGlyph : _Layout.provinceGlyph,
    );
    return _spec(id, b, _Layout.width, _Layout.height);
  }

  static PlateSpec _motorcycle(
    String id,
    ThailandCategory category,
    ThailandProvince province,
  ) {
    final b = _Builder();
    b.run(
      'series',
      ThailandAlphabets.letters,
      category.seriesLetters,
      _Layout.bikeCx - _Layout.bikePitch,
      _Layout.bikePitch,
      _Layout.bikeSeriesCy,
      _Layout.bikeBox,
    );
    b.run(
      'serial',
      ThailandAlphabets.digits,
      4,
      _Layout.bikeCx - 1.5 * _Layout.bikePitch,
      _Layout.bikePitch,
      _Layout.bikeSerialCy,
      _Layout.bikeBox,
    );
    b.text(
      province.thai,
      _Layout.bikeCx,
      _Layout.bikeProvinceCy,
      200,
      44,
      _Layout.bikeProvinceGlyph,
    );
    return _spec(id, b, _Layout.bikeWidth, _Layout.bikeHeight);
  }

  static PlateSpec _truck(String id, ThailandProvince province) {
    final b = _Builder();
    b.text(
      'THAILAND',
      _Layout.truckCaptionCx,
      _Layout.truckCaptionCy,
      _Layout.truckCaptionWidth,
      52,
      _Layout.truckCaptionGlyph,
    );
    b.run(
      'code',
      ThailandAlphabets.digits,
      2,
      _Layout.truckCodeCx,
      _Layout.truckCodePitch,
      _Layout.truckCaptionCy,
      _Layout.truckCodeBox,
    );
    b.run(
      'prefix',
      ThailandAlphabets.digits,
      2,
      _Layout.truckPrefixCx,
      _Layout.truckPitch,
      _Layout.truckSerialCy,
      _Layout.truckSerialBox,
    );
    b.run(
      'serial',
      ThailandAlphabets.digits,
      4,
      _Layout.truckSerialCx,
      _Layout.truckPitch,
      _Layout.truckSerialCy,
      _Layout.truckSerialBox,
    );
    b.text(
      '-',
      _Layout.truckDashCx,
      _Layout.truckSerialCy,
      50,
      _Layout.truckSerialBox,
      _Layout.truckSerialBox,
    );
    b.text(
      province.thai,
      _Layout.truckProvinceCx,
      _Layout.truckProvinceCy,
      260,
      52,
      _Layout.truckProvinceGlyph,
    );
    b.text(
      'ขส',
      _Layout.truckSealCx,
      _Layout.truckProvinceCy,
      50,
      44,
      _Layout.truckSealGlyph,
    );
    return _spec(id, b, _Layout.truckWidth, _Layout.truckHeight);
  }
}
