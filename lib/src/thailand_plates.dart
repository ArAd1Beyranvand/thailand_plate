import 'dart:math';

import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'thailand_country.dart';
import 'thailand_provinces.dart';
import 'thailand_themes.dart';
import 'thailand_usage.dart';

/// Ink positions on the Thai plates, in plate units: reference photos
/// flattened to one aspect, measured by projecting ink onto each axis, then
/// scaled by the real plate size (standard 15x34 cm = 340x150, motorcycle
/// 17.2x22 cm = 220x172, truck 22x44 cm = 440x220).
///
/// Rows are limited by the canvas, not the measurement. The standard serial's
/// 65-high ink wants a 118 box on a 150 plate whose serial centre is 48, so
/// the box is held to 96 and the ink is ~80% of reference. The truck's digits
/// are held to a 150 box because the 58 pitch squeezes anything taller. The
/// trailer's photo is fitted poorly, so it uses the standard layout.
///
/// Not implemented, for lack of a photograph to measure: the pictorial,
/// inter-province taxi, hired motorcycle, diplomatic, royal, police,
/// military and international-travel plates.
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
  static const double bikeSeriesCy = 41, bikeSerialCy = 138, bikeBox = 68;
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

  /// [count] cells from [firstCx] at [pitch], [box] tall about [cy]. A typed
  /// alphabet is one slot (`minLength` makes it variable, with no letter
  /// spacing); chosen letters are picked one by one, so each stays its own slot.
  void run(
    String key,
    PlateAlphabet alphabet,
    int count,
    double firstCx,
    double pitch,
    double cy,
    double box, {
    int? minLength,
  }) {
    final start = slots.length;
    final double left = firstCx - pitch / 2, top = cy - box / 2;
    if (alphabet.input == AlphabetInput.chosen) {
      slots.addAll(
        plateRegister(
          alphabet: alphabet,
          count: count,
          left: left,
          top: top,
          width: pitch,
          height: box,
        ),
      );
    } else {
      slots.add(
        PlateSlot(
          alphabet: alphabet,
          box: PlateBox(left, top, count * pitch, box),
          length: count,
          minLength: minLength,
          spacing: minLength == null ? max(0, pitch - 0.6 * 0.72 * box) : 0,
        ),
      );
    }
    groups.add(PlateTextGroup(<int>[for (var i = start; i < slots.length; i++) i], key: key));
  }

  /// Printed text centred on ([cx], [cy]).
  void text(String text, double cx, double cy, double width, double height, double glyph) =>
      labels.add(
        PlateLabel(
          text: text,
          box: PlateBox(cx - width / 2, cy - height / 2, width, height),
          glyphHeight: glyph,
        ),
      );
}

/// Three designs, twelve categories.
///
/// * Standard: groups `lead` (one digit, only with `leadingDigit`), `series`,
///   `serial`, the province beneath. The trade plate has one series letter and
///   a dash.
/// * Motorcycle: three rows. Groups `series` (three letters), `serial`.
/// * Truck: `THAILAND` and a province `code` over `prefix` (two digits), a
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
  static List<PlateSpec> get all => <PlateSpec>[for (final c in ThailandCategory.values) of(c)];

  static PlateSpec _spec(String id, _Builder b, double width, double height) => PlateSpec(
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
      b.run('lead', ThailandAlphabets.digits, 1, _Layout.leadCx, _Layout.leadPitch, cy, box);
    }
    b.run(
      'series',
      ThailandAlphabets.letters,
      category.seriesLetters,
      trade ? _Layout.tradeLetterCx : (lead ? _Layout.ledLettersCx : _Layout.lettersCx),
      trade ? _Layout.tradePitch : (lead ? _Layout.ledLettersPitch : _Layout.letterPitch),
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
      minLength: 1,
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

  static PlateSpec _motorcycle(String id, ThailandCategory category, ThailandProvince province) {
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
      minLength: 1,
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
    b.text('ขส', _Layout.truckSealCx, _Layout.truckProvinceCy, 50, 44, _Layout.truckSealGlyph);
    return _spec(id, b, _Layout.truckWidth, _Layout.truckHeight);
  }
}
