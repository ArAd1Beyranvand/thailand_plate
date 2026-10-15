import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thailand_plate/thailand_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category, drawn with real bold faces so the ink can be
/// measured against the references (`platekit golden-check`).
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final FontLoader loader = FontLoader('Roboto');
    for (final String path in const <String>[
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
      '/usr/share/fonts/truetype/noto/NotoSansThai-Bold.ttf',
    ]) {
      final File face = File(path);
      if (!face.existsSync()) continue;
      loader.addFont(face.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  /// category id -> (spec, theme, space-separated sample value)
  final Map<String, (PlateSpec, PlateTheme, String)> cases =
      <String, (PlateSpec, PlateTheme, String)>{
        'private': (ThailandPlates.private, ThailandThemes.private, 'ก ท 2058'),
        'van': (ThailandPlates.van, ThailandThemes.van, 'ฮ อ 3382'),
        'pickup': (ThailandPlates.pickup, ThailandThemes.pickup, 'ฒ ย 3201'),
        'tricycle': (
          ThailandPlates.tricycle,
          ThailandThemes.tricycle,
          'ศ ก 2345',
        ),
        'trailer': (ThailandPlates.trailer, ThailandThemes.trailer, 'ซ ค 1234'),
        'taxi': (ThailandPlates.taxi, ThailandThemes.taxi, 'ท พ 7459'),
        'tukTuk': (ThailandPlates.tukTuk, ThailandThemes.tukTuk, 'ส ก 6077'),
        'tourist': (ThailandPlates.tourist, ThailandThemes.tourist, 'ฌ ข 4260'),
        'private_short_serial': (
          ThailandPlates.private,
          ThailandThemes.private,
          'ก ท 7',
        ),
        'trade': (ThailandPlates.trade, ThailandThemes.trade, 'ก 2323'),
        'motorcycle': (
          ThailandPlates.motorcycle,
          ThailandThemes.motorcycle,
          'ข น ษ 6601',
        ),
        'truckPrivate': (
          ThailandPlates.truckPrivate,
          ThailandThemes.truckPrivate,
          '01 90 9397',
        ),
        'truckHired': (
          ThailandPlates.truckHired,
          ThailandThemes.truckHired,
          '42 70 2157',
        ),
      };

  test('serial is one field of one to four digits', () {
    final PlateSpec spec = ThailandPlates.private;
    expect(spec.slots.length, 3);
    expect(spec.slots[2].minLength, 1);
    expect(spec.slots[2].length, 4);
    final PlateController c = PlateController.fromValues(spec, ['ก', 'ท', '7']);
    expect(c.isCompleted, isTrue);
    c.dispose();
  });

  for (final MapEntry<String, (PlateSpec, PlateTheme, String)> c
      in cases.entries) {
    testWidgets(c.key, (tester) async {
      final (PlateSpec spec, PlateTheme theme, String values) = c.value;
      final PlateController controller = PlateController.fromValues(
        spec,
        values.split(' '),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 680,
                height: 300,
                child: PlateThemeScope(
                  theme: theme,
                  child: PlateView(
                    controller: controller,
                    theme: theme,
                    country: ThailandCountry.thailand,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PlateView),
        matchesGoldenFile('goldens/th_${c.key}.png'),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }
}
