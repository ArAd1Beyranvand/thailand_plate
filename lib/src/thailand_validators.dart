import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

/// Judges a Thai plate by the registers its spec has, per the article: an
/// optional leading digit, the series letters, and a serial of one to four
/// digits without leading zeroes (bus and truck plates print two series digits
/// and four serial digits, zeroes kept). Reports, never bars a keystroke.
class ThailandValidator extends GatedPlateValidator {
  const ThailandValidator();

  @override
  String get gateGroup => 'serial';

  static const String reasonLead = 'A leading digit is 1 to 9.';
  static const String reasonSeries = 'The series is Thai consonants.';
  static const String reasonPrefix = 'The series is two digits.';
  static const String reasonSerial = 'The number is 1 to 9999.';
  static const String reasonTruckSerial = 'The number is four digits.';
  static const String reasonCode = 'The province code is two digits.';

  @override
  PlateValidation judge(PlateEntry entry) {
    final PlateSpec spec = entry.spec;
    final String lead = entry.group('lead');
    if (spec.indicesOfGroup('lead').isNotEmpty &&
        lead.isNotEmpty &&
        !RegExp(r'^[1-9]$').hasMatch(lead)) {
      return const PlateValidation.invalid(reasonLead);
    }
    final int letters = spec.indicesOfGroup('series').length;
    if (letters > 0) {
      final List<String> series = entry
          .group('series')
          .runes
          .map(String.fromCharCode)
          .toList();
      if (series.length != letters ||
          !series.every(ThailandAlphabets.letters.characters.contains)) {
        return const PlateValidation.invalid(reasonSeries);
      }
    }
    if (spec.indicesOfGroup('prefix').isNotEmpty) {
      if (!isDigitsOfLength(entry.group('prefix'), 2)) {
        return const PlateValidation.invalid(reasonPrefix);
      }
      if (!isDigitsOfLength(entry.group('serial'), 4)) {
        return const PlateValidation.invalid(reasonTruckSerial);
      }
      final String code = entry.group('code');
      if (code.isNotEmpty && !isDigitsOfLength(code, 2)) {
        return const PlateValidation.invalid(reasonCode);
      }
      return const PlateValidation.valid();
    }
    if (!RegExp(r'^[1-9][0-9]{0,3}$').hasMatch(entry.group('serial'))) {
      return const PlateValidation.invalid(reasonSerial);
    }
    return const PlateValidation.valid();
  }
}
