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
  final Map<String, (PlateSpec, PlateTheme, String)>
  cases = <String, (PlateSpec, PlateTheme, String)>{
    'private': (ThailandPlates.private, ThailandThemes.private, 'ก ท 2 0 5 8'),
    'van': (ThailandPlates.van, ThailandThemes.van, 'ฮ อ 3 3 8 2'),
    'pickup': (ThailandPlates.pickup, ThailandThemes.pickup, 'ฒ ย 3 2 0 1'),
    'tricycle': (
      ThailandPlates.tricycle,
      ThailandThemes.tricycle,
      'ศ ก 2 3 4 5',
    ),
    'trailer': (ThailandPlates.trailer, ThailandThemes.trailer, 'ซ ค 1 2 3 4'),
    'taxi': (ThailandPlates.taxi, ThailandThemes.taxi, 'ท พ 7 4 5 9'),
    'tukTuk': (ThailandPlates.tukTuk, ThailandThemes.tukTuk, 'ส ก 6 0 7 7'),
    'tourist': (ThailandPlates.tourist, ThailandThemes.tourist, 'ฌ ข 4 2 6 0'),
    'trade': (ThailandPlates.trade, ThailandThemes.trade, 'ก 2 3 2 3'),
    'motorcycle': (
      ThailandPlates.motorcycle,
      ThailandThemes.motorcycle,
      'ข น ษ 6 6 0 1',
    ),
    'truckPrivate': (
      ThailandPlates.truckPrivate,
      ThailandThemes.truckPrivate,
      '0 1 9 0 9 3 9 7',
    ),
    'truckHired': (
      ThailandPlates.truckHired,
      ThailandThemes.truckHired,
      '4 2 7 0 2 1 5 7',
    ),
  };

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
